import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:quizgram/screens/quiz/olympic_result_screen.dart';
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

  Future<void> fetchData() async {
    var token = box.get('token');
    var id = box.get('id');
    print(id);
    var headers = {'Authorization': 'Bearer ${token}'};
    var request = http.MultipartRequest(
        'POST', Uri.parse(WebApiConstans.playOlympicExam));
    request.fields
        .addAll({'exam_day_id': '${widget.examId}', 'user_id': '${id}'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      final data = json.decode(res);
      setState(() {
        _isLoading = false;
        _secondsRemaining = data['day']['time'];
        olympicsData = data['data'];
      });
      startTimer();
    } else {
      print(response.reasonPhrase);
    }
  }

  void checkTest() {
    double total = 0.0;
    selectedAnswers.forEach((key, value) {
      if (value['correct'] == 1) {
        total = total + value['ball'];
      }
    });
    print(total);
    Get.to(OlympicResult(
        olympicsData: olympicsData, selectedAnswers: selectedAnswers));
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
            _isLoading
                ? Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(100)),
                    child: Center(child: CircularProgressIndicator()))
                : Container(
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
                                olympicsData[index]['section_photo'] !=
                                        "no_photo"
                                    ? Padding(
                                        child: Image.network(
                                            "${AssetUrls.quizPhotos}/${olympicsData[index]['section_photo']}"),
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ScreenUtil().setWidth(16)),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: ScreenUtil().setHeight(10),
                                ),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                    olympicsData[index]['quizzes'].length,
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
                                            child: olympicsData[index]['quizzes'][indexQuizzes]['math'] == "" ? widgetText(
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
                                          ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemCount: olympicsData[index]
                                                          ['quizzes']
                                                      [indexQuizzes]['answers']
                                                  .length,
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (context, indexAnswers) {
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                        bottom: ScreenUtil()
                                                            .setHeight(16),
                                                        left: ScreenUtil()
                                                            .setWidth(16),
                                                        right: ScreenUtil()
                                                            .setWidth(16),
                                                      ),
                                                      child: widgetButtonQuiz(
                                                        olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['math'] != "" ?
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
                                                              color: selectedAnswers[olympicsData[index]['quizzes'][indexQuizzes]['id']] == olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]
                                                                  ? Colors.white
                                                                  : Colors.black,
                                                            ),
                                                            () {
                                                          setState(() {
                                                            selectedAnswers[olympicsData[
                                                            index]
                                                            ['quizzes']
                                                            [indexQuizzes][
                                                            'id']] = olympicsData[
                                                            index]
                                                            ['quizzes']
                                                            [indexQuizzes]
                                                            ['answers'][indexAnswers];
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
                                                        color: selectedAnswers[olympicsData[
                                                        index]['quizzes'][
                                                        indexQuizzes]
                                                        ['id']] ==
                                                            olympicsData[index][
                                                            'quizzes']
                                                            [indexQuizzes]
                                                            ['answers']
                                                            [indexAnswers]
                                                            ? isSelected
                                                            : isUnselected,
                                                        widthBorder: 1.0,
                                                        align: Alignment.centerLeft,
                                                        width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                      ),
                                                    );



                                                // return Container(
                                                //   margin: EdgeInsets.only(
                                                //     bottom: ScreenUtil()
                                                //         .setHeight(16),
                                                //     left: ScreenUtil()
                                                //         .setWidth(16),
                                                //     right: ScreenUtil()
                                                //         .setWidth(16),
                                                //   ),
                                                //   child: widgetButton(
                                                //     widgetText(
                                                //       olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['answer'],
                                                //       fontWeight:FontWeight.w400,
                                                //       fontSize: ScreenUtil().setSp(16),
                                                //       align: TextAlign.left,
                                                //       color: selectedAnswers[olympicsData[index]['quizzes'][indexQuizzes]['id']] == olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]
                                                //           ? Colors.white
                                                //           : Colors.black,
                                                //     ),
                                                //     () {
                                                //       setState(() {
                                                //         selectedAnswers[olympicsData[
                                                //                         index]
                                                //                     ['quizzes']
                                                //                 [indexQuizzes][
                                                //             'id']] = olympicsData[
                                                //                         index]
                                                //                     ['quizzes']
                                                //                 [indexQuizzes]
                                                //             ['answers'][indexAnswers];
                                                //       });
                                                //     },
                                                //     height: 56.0,
                                                //     radius: 20.0,
                                                //     paddingBtn: EdgeInsets.only(
                                                //       left: ScreenUtil()
                                                //           .setWidth(24),
                                                //     ),
                                                //     colorBorder:
                                                //         ColorsHelpers.grey5,
                                                //     color: selectedAnswers[olympicsData[
                                                //                             index]
                                                //                         [
                                                //                         'quizzes']
                                                //                     [
                                                //                     indexQuizzes]
                                                //                 ['id']] ==
                                                //             olympicsData[index][
                                                //                             'quizzes']
                                                //                         [indexQuizzes]
                                                //                     ['answers']
                                                //                 [indexAnswers]
                                                //         ? isSelected
                                                //         : isUnselected,
                                                //     widthBorder: 1.0,
                                                //     align: Alignment.centerLeft,
                                                //     width:
                                                //         MediaQuery.of(context)
                                                //             .size
                                                //             .width,
                                                //   ),
                                                // );
                                              })
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
