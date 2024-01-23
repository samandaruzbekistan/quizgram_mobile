import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../models/utils_model.dart';
import '../../utils/constant.dart';
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
  Color isSelected = ColorsHelpers.grey5;
  Color isUnselected = Colors.white;
  Color btnColor = Colors.white;
  bool isPressed = false;
  bool timeOut = false;
  bool isLoading = false;
  bool isPlaying = false;
  bool isRecordedReady = false;
  bool recorded = false;
  int durationTime = 0;
  int? currentIndex = 0;
  String answerPick = '';
  String correctAnswer = '';
  Map<int, int> selectedAnswers = {};
  List olympicsData = [];

  Future<void> fetchData() async {
    var token = box.get('token');
    var id = box.get('id');
    print(id);
    var headers = {'Authorization': 'Bearer ${token}'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://mobile.quizgram.uz/api/playOlympicExam'));
    request.fields
        .addAll({'exam_day_id': '${widget.examId}', 'user_id': '${id}'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      final data = json.decode(res);
      setState(() {
        _isLoading = false;
        olympicsData = data['data'];
      });
      print(data);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geeks for Geeks'),
        backgroundColor: const Color(0xFF00E676),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
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
                                  bottom: ScreenUtil().setHeight(8)),
                              child: widgetText(
                                  '${olympicsData[index]['section_name']}',
                                  color: ColorsHelpers.grey2,
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w500),
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
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
                                          bottom: ScreenUtil().setHeight(24),
                                        ),
                                        child: widgetText(
                                          olympicsData[index]['quizzes']
                                              [indexQuizzes]['quiz'],
                                          fontWeight: FontWeight.w500,
                                          align: TextAlign.center,
                                          fontSize: ScreenUtil().setSp(20),
                                        ),
                                      ),
                                      ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: olympicsData[index]
                                                      ['quizzes'][indexQuizzes]
                                                  ['answers']
                                              .length,
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemBuilder: (context, indexAnswers) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                bottom:
                                                    ScreenUtil().setHeight(16),
                                                left: ScreenUtil().setWidth(16),
                                                right:
                                                    ScreenUtil().setWidth(16),
                                              ),
                                              child: widgetButton(
                                                widgetText(
                                                  olympicsData[index]['quizzes']
                                                              [indexQuizzes]
                                                          ['answers']
                                                      [indexAnswers]['answer'],
                                                  fontWeight: FontWeight.w400,
                                                  fontSize:
                                                      ScreenUtil().setSp(16),
                                                  align: TextAlign.left,
                                                  color: Colors.black,
                                                ),
                                                () {
                                                  setState(() {
                                                    selectedAnswers[olympicsData[index]['quizzes']
                                                    [indexQuizzes]['id']] =
                                                    olympicsData[index]['quizzes']
                                                    [indexQuizzes]['answers']
                                                    [indexAnswers]['id'];
                                                  });
                                                },
                                                height: 56.0,
                                                radius: 20.0,
                                                paddingBtn: EdgeInsets.only(
                                                  left:
                                                      ScreenUtil().setWidth(24),
                                                ),
                                                colorBorder:
                                                    ColorsHelpers.grey5,
                                                color: selectedAnswers[olympicsData[index]['quizzes']
                                                [indexQuizzes]['id']] ==
                                                    olympicsData[index]['quizzes']
                                                    [indexQuizzes]['answers']
                                                    [indexAnswers]['id']
                                                    ? isSelected
                                                    : isUnselected,
                                                widthBorder: 1.0,
                                                align: Alignment.centerLeft,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              ),
                                            );
                                          })
                                    ],
                                  );
                                }),
                          ]);
                    },
                  )
          ],
        ),
      ),
    );
  }
}
