import 'dart:async';
import 'dart:convert';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:quizgram/screens/olympics_screen/olympic_result_screen.dart';
import 'package:quizgram/screens/olympics_screen/quiz_audio_player.dart';
import '../../utils/constant.dart';
import '../../utils/images.dart';
import '../../utils/widget_assets.dart';

class PlayOlympicQuiz extends StatefulWidget {
  const PlayOlympicQuiz({Key? key, required this.examId}) : super(key: key);
  final int examId;

  @override
  State<PlayOlympicQuiz> createState() => _PlayOlympicQuizState();
}

class _PlayOlympicQuizState extends State<PlayOlympicQuiz> {
  var box = Hive.box('user');
  bool _isLoading = true;
  Color isSelected = ColorsHelpers.dullLavender;
  Color isUnselected = Colors.white;
  Color btnColor = Colors.white;
  late Timer _timer;
  int _secondsRemaining = 0;
  Map<int, Map<String, dynamic>> selectedAnswers = {};
  List olympicsData = [];
  int exam_id = 0;
  Map<String, TextEditingController> _puzzleTextControllers = {};
  Map<String, List<String>> _tagsList = {};
  Map<String, TextEditingController> _writingControllers = {};
  Map<String, Map<String, dynamic>> _selectedAnswersJson = {};

  List<String> tags = [];

  String displayString = '';


  Future<void> fetchData() async {
    var token = box.get('token');
    var id = box.get('id');
    var headers = {'Authorization': 'Bearer ${token}'};
    var request = http.MultipartRequest('POST', Uri.parse(WebApiConstans.playOlympicExam));
    request.fields.addAll({'exam_day_id': '${widget.examId}', 'user_id': '${id}'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      final data = json.decode(res);
      setState(() {
        _isLoading = false;
        _secondsRemaining = data['day']['time'];
        olympicsData = data['data'];
        exam_id = data['exam']['id'];
      });
      olympicsData.forEach((section) {
        var quizzes = section['quizzes'];
        quizzes.forEach((quiz){
          if(quiz['type'] == 'writing'){
            setState(() {
              _writingControllers["${quiz['id']}"] = new TextEditingController();
            });
          }
          else if(quiz['type'] == 'puzzle'){
            setState(() {
              _tagsList["${quiz['id']}"] = [];
              _puzzleTextControllers["${quiz['id']}"] = new TextEditingController();
            });
          }
        });
      });
      startTimer();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> checkTest() async {
    _timer.cancel();
    double total = 0.0;
    int correct = 0;
    int inCorrect = 0;
    var token = box.get('token');
    setState(() {
      _isLoading = true;
    });
    selectedAnswers.forEach((key, value) {
      _selectedAnswersJson["${key}"] = value;
      if (value['type'] == 'puzzle') {
        if(value['correct_text'] == value['answer_data']){
          total = total + value['ball'];
          correct++;
        }
        else{
          inCorrect++;
        }
      }
      else if(value['type'] == 'quiz'){
        if (value['answer_data']['correct'] == 1) {
          total = total + value['answer_data']['ball'];
          correct++;
        }
        else{
          inCorrect++;
        }
      }
    });

    var json_selectedAnswers = jsonEncode(_selectedAnswersJson);
    var request = http.MultipartRequest('POST', Uri.parse(WebApiConstans.saveOlympicExamResult));
    request.fields.addAll({
      'exam_id': "${exam_id}",
      'selectedAnswers': '${json_selectedAnswers}',
      'correct': '${correct}',
      'incorrect': '${inCorrect}',
      'total': '${total}'
    });
    var headers = {
      'Authorization': 'Bearer ${token}'
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Get.offAll(OlympicResult(olympicsData: olympicsData, selectedAnswers: selectedAnswers, correct: correct, total: total, inCorrect: inCorrect,));
    }
    else{
      var res = await response.stream.bytesToString();
    }
  }


  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          // Timer reached 0, do something here (e.g., navigate to another screen)
          timer.cancel(); // Stop the timer
          checkTest(); // Call checkTest when the timer reaches zero
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }


  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: ScreenUtil().setHeight(34),
              width: MediaQuery.of(context).size.width * 0.3,
              margin: EdgeInsets.only(right: ScreenUtil().setWidth(24)),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: ColorsHelpers.dullLavender),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SvgPicture.asset(
                  Images.clockIcon,
                  color: Colors.white,
                  width: ScreenUtil().setSp(20),
                ),
                const SizedBox(
                  width: 4,
                ),
                widgetText(formatDuration(_secondsRemaining),
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.w500,
                    color: Colors.white)
              ]),
            ),
            Container(
              // width: ScreenUtil().setWidth(50),
              height: ScreenUtil().setHeight(34),
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
              margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(24),
              ),
              decoration: BoxDecoration(
                  color: ColorsHelpers.orangeSecond,
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: GestureDetector(
                onTap: () {
                  checkTest();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline_outlined,
                      color: Colors.white,
                      weight: ScreenUtil().setSp(16),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    widgetText('YAKUNLASH',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(16))
                  ],
                ),
              ),
            ),
          ],
        ),
        backgroundColor: ColorsHelpers.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isLoading) Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(100)),
                    child: Center(child: CircularProgressIndicator())) else Container(
                    color: ColorsHelpers.primaryColor,
                    // height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height / 1.21,
                      margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(24),
                          bottom: ScreenUtil().setHeight(0),
                          left: ScreenUtil().setWidth(8),
                          right: ScreenUtil().setWidth(8)),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                          color: Colors.white),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: olympicsData.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(32),
                                    left: ScreenUtil().setWidth(16),
                                  ),
                                  child: widgetText(
                                      '${olympicsData[index]['section_name']}',
                                      color: ColorsHelpers.primaryColor,
                                      fontSize: ScreenUtil().setSp(20),
                                      fontWeight: FontWeight.w500),
                                ),
                                olympicsData[index]['section_topic'] != ""
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(16),
                                            bottom: ScreenUtil().setHeight(8)),
                                        child: widgetText(
                                            '${olympicsData[index]['section_topic']}',
                                            color: ColorsHelpers.grey2,
                                            fontSize: ScreenUtil().setSp(15),
                                            fontWeight: FontWeight.w500),
                                      )
                                    : Container(),
                                olympicsData[index]['section_photo'] != "no_photo"
                                    ? Padding(
                                        child: Image.network("${AssetUrls.quizPhotos}/${olympicsData[index]['section_photo']}"),
                                        padding: EdgeInsets.symmetric(horizontal:ScreenUtil().setWidth(16)),
                                      )
                                    : Container(),
                                olympicsData[index]['section_audio'] != "no_audio"
                                    ? Container(
                                        margin: EdgeInsets.only(left: ScreenUtil().setWidth(16),bottom: ScreenUtil().setHeight(8)),
                                        child: QuizAudioPlayer(audioUrl: "${AssetUrls.olympicAudios}/${olympicsData[index]['audio']}"),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: ScreenUtil().setHeight(10),
                                ),
                                ListView.builder(
                                    physics:const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount:olympicsData[index]['quizzes'].length,
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemBuilder: (context, indexQuizzes) {
                                      return Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(8),
                                              left: ScreenUtil().setWidth(16),
                                              right: ScreenUtil().setWidth(16),
                                              bottom:
                                                  ScreenUtil().setHeight(24),
                                            ),
                                            child: olympicsData[index]['quizzes'][indexQuizzes]['math'] == null ? widgetText(
                                              "${indexQuizzes+1}) ${olympicsData[index]['quizzes'][indexQuizzes]['quiz']}",
                                              fontWeight: FontWeight.w500,
                                              align: TextAlign.center,
                                              fontSize: ScreenUtil().setSp(18),
                                            ) : widgetTextLatex(
                                              olympicsData[index]['quizzes'][indexQuizzes]['quiz'],  "${indexQuizzes+1}) ${olympicsData[index]['quizzes'][indexQuizzes]['math']}",
                                              fontWeight:FontWeight.w500,
                                              fontSize: ScreenUtil().setSp(16),
                                              align: TextAlign.left,
                                              color: Colors.black,
                                            ),
                                          ),
                                          olympicsData[index]['quizzes'][indexQuizzes]['photo'] != "no_photo" ? Padding(
                                            child: Image.network(
                                                "${AssetUrls.quizPhotos}/${olympicsData[index]['quizzes'][indexQuizzes]['photo']}"),
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                ScreenUtil().setWidth(16)),
                                          )
                                              : Container(),
                                          olympicsData[index]['quizzes'][indexQuizzes]['audio'] != "no_audio" ? QuizAudioPlayer(audioUrl: "${AssetUrls.olympicAudios}/${olympicsData[index]['quizzes'][indexQuizzes]['audio']}")
                                              : Container(),
                                          olympicsData[index]['quizzes'][indexQuizzes]['type'] == "quiz4" || olympicsData[index]['quizzes'][indexQuizzes]['type'] == "quiz6" ? ListView.builder(
                                              physics:const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemCount: olympicsData[index]['quizzes'][indexQuizzes]['answers'].length,
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (context, indexAnswers) {
                                                    return Container(
                                                      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(16),
                                                        left: ScreenUtil().setWidth(16),
                                                        right: ScreenUtil().setWidth(16),
                                                      ),
                                                      child: widgetButtonQuiz(
                                                        olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['math'] != null ?
                                                        widgetTextLatex(
                                                          olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['answer'], olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['math'],
                                                          fontWeight:FontWeight.w400,
                                                          fontSize: ScreenUtil().setSp(16),
                                                          align: TextAlign.left,
                                                          color: selectedAnswers[olympicsData[index]['quizzes'][indexQuizzes]['id']] == olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ) : widgetText(
                                                              olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['answer'],
                                                              fontWeight:FontWeight.w400,
                                                              fontSize: ScreenUtil().setSp(16),
                                                              align: TextAlign.left,
                                                              color: selectedAnswers[olympicsData[index]['quizzes'][indexQuizzes]['id']]?['answer_data'] == olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]
                                                                  ? Colors.white
                                                                  : Colors.black,
                                                            ),
                                                            () {
                                                          setState(() {
                                                            selectedAnswers[olympicsData[index]['quizzes'][indexQuizzes]['id']] = {"type" : "quiz", "answer_data" : olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]};
                                                          });
                                                        },
                                                        height: 56.0,
                                                        radius: 20.0,
                                                        paddingBtn: EdgeInsets.only(
                                                          left: ScreenUtil()
                                                              .setWidth(24),
                                                        ),
                                                        colorBorder:
                                                        ColorsHelpers.grey5,
                                                        color: selectedAnswers[olympicsData[index]['quizzes'][indexQuizzes]['id']]?['answer_data'] ==olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]
                                                            ? isSelected
                                                            : isUnselected,
                                                        widthBorder: 1.0,
                                                        align: Alignment.centerLeft,
                                                        width:MediaQuery.of(context).size.width,
                                                      ),
                                                );
                                              }) : Container(),
                                          olympicsData[index]['quizzes'][indexQuizzes]['type'] == "writing"
                                              ? Container(
                                                margin: EdgeInsets.only(
                                                  left: ScreenUtil().setWidth(16),
                                                  right: ScreenUtil().setWidth(16),
                                                ),
                                                child: TextFormField(
                                                    maxLines: 5,
                                                    onChanged: (val){
                                                      setState((){
                                                        selectedAnswers[olympicsData[index]['quizzes'][indexQuizzes]['id']] = {"type" : "writing", "answer_data" : val, 'ball' : 0, 'is_check':0};
                                                      });
                                                    },
                                                    controller : _writingControllers['${olympicsData[index]['quizzes'][indexQuizzes]['id']}'],
                                                    decoration:InputDecoration(
                                                      focusedBorder:OutlineInputBorder(
                                                        borderRadius:BorderRadius.circular(20.0),
                                                        borderSide:BorderSide(width:2,color:ColorsHelpers.grey5),
                                                      ),
                                                      enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(20.0),
                                                        borderSide:BorderSide(width:2,color:ColorsHelpers.grey5),
                                                      ),
                                                      border: OutlineInputBorder(borderRadius:BorderRadius.circular(20.0)),
                                                      fillColor:Colors.white,
                                                      filled: true,
                                                      hintText: "Matn...",
                                                      contentPadding:EdgeInsets.only(left: ScreenUtil().setWidth(19),
                                                      ),
                                                    ),
                                                  ),
                                              )
                                              : Container(),
                                          olympicsData[index]['quizzes'][indexQuizzes]['type'] == "puzzle" ? Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  top: ScreenUtil().setHeight(8),
                                                  left: ScreenUtil().setWidth(16),
                                                  right: ScreenUtil().setWidth(16),
                                                  bottom: ScreenUtil().setHeight(24),
                                                ),
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height * 0.06,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: const Color.fromRGBO(0, 98, 204, 0.2),
                                                    width: ScreenUtil().setSp(2),
                                                  ),
                                                  color: ColorsHelpers.grey5,
                                                ),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  maxLines: 3,
                                                  onTap: () {},
                                                  controller : _puzzleTextControllers['${olympicsData[index]['quizzes'][indexQuizzes]['id']}'],
                                                  decoration:InputDecoration(
                                                    focusedBorder:OutlineInputBorder(
                                                      borderRadius:BorderRadius.circular(20.0),
                                                      borderSide:BorderSide(width:2,color:ColorsHelpers.grey5),
                                                    ),
                                                    enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(20.0),
                                                      borderSide:BorderSide(width:2,color:ColorsHelpers.grey5),
                                                    ),
                                                    border: OutlineInputBorder(borderRadius:BorderRadius.circular(20.0)),
                                                    fillColor:Colors.white,
                                                    filled: true,
                                                    contentPadding:EdgeInsets.only(left: ScreenUtil().setWidth(19),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  child: ChipsChoice<
                                                      String>.multiple( value: _tagsList["${olympicsData[index]['quizzes'][indexQuizzes]['id']}"]!,
                                                      onChanged: (value){
                                                        setState((){
                                                          _tagsList["${olympicsData[index]['quizzes'][indexQuizzes]['id']}"] = value;
                                                          displayString =_tagsList["${olympicsData[index]['quizzes'][indexQuizzes]['id']}"]!.join(' ');
                                                          _puzzleTextControllers["${olympicsData[index]['quizzes'][indexQuizzes]['id']}"]?.text =displayString;
                                                          selectedAnswers[olympicsData[index]['quizzes'][indexQuizzes]['id']] = {"type" : "puzzle",'ball': olympicsData[index]['quizzes'][indexQuizzes]['ball'],'correct_text' :olympicsData[index]['quizzes'][indexQuizzes]['correct_text'], "answer_data" : displayString};
                                                        });
                                                    },
                                                    choiceItems: C2Choice.listFrom(
                                                      source: jsonDecode(olympicsData[index]['quizzes'][indexQuizzes]['words_json']),
                                                      value: (i, v) => v.toString(),
                                                      label: (i, v) => v.toString(),
                                                    ),
                                                    choiceStyle: C2ChoiceStyle(
                                                        labelStyle: const TextStyle(fontWeight:FontWeight.w400),
                                                        showCheckmark:false,
                                                        backgroundColor:Colors.white,
                                                        color: Colors.black,
                                                        borderColor: ColorsHelpers.grey5,
                                                        borderRadius:const BorderRadius.all(Radius.circular(16))),
                                                    wrapped: true,
                                                    choiceActiveStyle: C2ChoiceStyle(
                                                        labelStyle: const TextStyle(fontWeight: FontWeight.w500),
                                                        showCheckmark:false,
                                                        avatarBorderColor: Colors.red,
                                                        backgroundColor: ColorsHelpers.primaryColor.withOpacity(0.2),
                                                        color: Colors.black,
                                                        borderRadius:const BorderRadius.all(Radius.circular(16))),
                                                    textDirection:TextDirection.ltr,
                                                  )),
                                            ],
                                          ) : Container(),
                                        ],
                                      );
                                    }),
                              ]);
                        },
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  String formatDuration(int secondsRemaining) {
    // Format remaining seconds into MM:SS
    Duration duration = Duration(seconds: secondsRemaining);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
