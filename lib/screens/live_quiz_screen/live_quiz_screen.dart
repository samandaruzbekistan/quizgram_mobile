import 'dart:async';
import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:quizgram/models/utils_model.dart';
import 'package:quizgram/screens/live_quiz_screen/quiz_complete_screen.dart';
import 'package:quizgram/utils/music_visualizer_main.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:quizgram/utils/widget_assets.dart';

import '../../utils/images.dart';

class LiveQuizScreen extends StatefulWidget {
  const LiveQuizScreen({super.key});

  @override
  State<LiveQuizScreen> createState() => _LiveQuizScreenState();
}

class _LiveQuizScreenState extends State<LiveQuizScreen> {
  bool isStep1 = false;
  bool isStep2 = false;
  bool isStep3 = false;
  bool isStep4 = false;
  bool isStep5 = false;
  bool isStep6 = false;
  bool isPressed = false;
  bool timeOut = false;
  bool isLoading = false;
  bool isPlaying = false;
  bool isRecordedReady = false;
  bool recorded = false;

  int durationTime = 0;
  int? currentIndex = 0;
  int _start = 0;

  Color isSelected = ColorsHelpers.grey5;
  Color isUnselected = Colors.white;
  Color btnColor = Colors.white;

  String answerPick = '';
  String correctAnswer = '';

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  final recorder = FlutterSoundRecorder();
  // final audioPlayer = AudioPlayer();
  File fileAudio = File('');

  late Timer _timer;

  List<bool>? isChecked;
  List<bool>? isVoted;
  List<String> listCandidate = [
    'Mohamed Salah',
    'Marcus Rashford',
    'Sadio Mane',
    'Aubameyang'
  ];
  List<String> listClub = [
    'Manchester United',
    'Leeds United',
    'Fulham',
    'Leicester City'
  ];

  final textFieldController = TextEditingController();

  void startTimer({bool? isStep}) {
    const oneSec = Duration(milliseconds: 1000);
    _start = 10;
    durationTime = 10000;
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            timeOut = true;

            setState(() {
              isStep = true;
            });

            if (isStep6 == true &&
                isStep5 == true &&
                isStep4 == true &&
                isStep3 == true &&
                isStep2 == true &&
                isStep1 == true) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const QuizCompleteScreen();
                  },
                ),
              );
            } else if (isStep6 == false &&
                isStep5 == true &&
                isStep4 == true &&
                isStep3 == true &&
                isStep2 == true &&
                isStep1 == true) {
              setState(() {
                isLoading = true;
                Future.delayed(const Duration(milliseconds: 500), () {
                  isLoading = false;
                  timeOut = false;
                  isStep6 = true;

                  startTimer();
                });
              });
            } else if (isStep5 == false &&
                isStep4 == true &&
                isStep3 == true &&
                isStep2 == true &&
                isStep1 == true) {
              setState(() {
                isLoading = true;
                Future.delayed(const Duration(milliseconds: 500), () {
                  isLoading = false;
                  timeOut = false;
                  isStep5 = true;
                  startTimer();
                });
              });
            } else if (isStep4 == false &&
                isStep3 == true &&
                isStep2 == true &&
                isStep1 == true) {
              timeOut = true;
            } else if (isStep3 == false && isStep2 == true && isStep1 == true) {
              setState(() {
                isLoading = true;
                Future.delayed(const Duration(milliseconds: 500), () {
                  isLoading = false;
                  timeOut = false;
                  isStep3 = true;
                  startTimer();
                });
              });
            } else if (isStep2 == true) {
            } else if (isStep1 == true && isStep2 == false) {
              setState(() {
                isLoading = true;
                Future.delayed(const Duration(milliseconds: 500), () {
                  isStep2 = true;
                  timeOut = false;
                  isLoading = false;
                  startTimer();
                });
              });
            }
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  List<QuestionModel> questions = [
    QuestionModel(
        'Which player scored the fastest hat-trick in the Premier League?', {
      "Robin Van Persie": false,
      "Sadio Mane": true,
      "Harry Kane": false,
      "Christian Benteke": false,
    })
  ];

  int tag = 0;

  List<String> tags = [];

  String displayString = '';

  List<String> options = ['Under ', 'Unmanned ', 'Air ', 'Aerial ', 'Vehicle '];

  @override
  void dispose() {
    _timer.cancel();
    recorder.closeRecorder();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    initRecorder();
    setAudio();
    isChecked = List<bool>.filled(4, false);
    isVoted = List<bool>.filled(4, false);
    super.initState();
  }

  Future setAudio() async {
    String file = fileAudio.toString();
    // final result = await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   final file = File(result.files.single.path!);
    // }
    // await audioPlayer.play(file);
  }

  Future initRecorder() async {
    // ignore: unused_local_variable
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
    isRecordedReady = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future record() async {
    if (!isRecordedReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecordedReady) return;
    final path = await recorder.stopRecorder();
    final audioFile = File(path!);
    fileAudio = audioFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorsHelpers.primaryColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Wrap(children: [
          !timeOut
              ? Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(50),
                        height: ScreenUtil().setHeight(34),
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(24),
                        ),
                        decoration: BoxDecoration(
                            color: ColorsHelpers.dullLavender,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.person_outline,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            widgetText('1',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(12))
                          ],
                        ),
                      ),
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width / 2.1,
                        lineHeight: ScreenUtil().setHeight(4),
                        percent: !isStep1
                            ? 0.2
                            : !isStep2
                                ? 0.4
                                : !isStep3
                                    ? 0.6
                                    : 1,
                        animation: true,
                        barRadius: const Radius.circular(8),
                        backgroundColor: Colors.white.withOpacity(0.10),
                        progressColor: Colors.white,
                      ),
                      Container(
                        height: ScreenUtil().setHeight(34),
                        width: ScreenUtil().setWidth(60),
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setWidth(24)),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            color: ColorsHelpers.orangeSecond),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                Images.jigsaw,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              widgetText('35',
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)
                            ]),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              right: ScreenUtil().setWidth(20),
                              left: ScreenUtil().setWidth(20)),
                          alignment: Alignment.center,
                          child: widgetText('Answers Explanation',
                              fontSize: ScreenUtil().setSp(24),
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        const Icon(
                          Icons.close,
                          color: Colors.white,
                        )
                      ]),
                ),
          isLoading == false
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.21,
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(24),
                      bottom: ScreenUtil().setHeight(0),
                      left: ScreenUtil().setWidth(8),
                      right: ScreenUtil().setWidth(8)),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        timeOut == false
                            ? Center(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(24)),
                                  child: CircularPercentIndicator(
                                    radius: 28.0,
                                    lineWidth: 28.0,
                                    percent: 1,
                                    animationDuration: durationTime,
                                    animation: true,
                                    reverse: true,
                                    center: widgetText('$_start',
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(14),
                                        color: Colors.white),
                                    circularStrokeCap: CircularStrokeCap.butt,
                                    backgroundColor: ColorsHelpers.pink2,
                                    progressColor: ColorsHelpers.pink,
                                    animateFromLastPercent: true,
                                    onAnimationEnd: () {
                                      setState(() {
                                        // startTimer();
                                      });
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                        isStep1 == false
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(32),
                                        left: ScreenUtil().setWidth(16),
                                        bottom: ScreenUtil().setHeight(8)),
                                    child: widgetText('QUESTION 3 OF 10',
                                        color: ColorsHelpers.grey2,
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(8),
                                        left: ScreenUtil().setWidth(16),
                                        right: ScreenUtil().setWidth(16),
                                        bottom: ScreenUtil().setHeight(24)),
                                    child: widgetText(
                                        questions.first.question.toString(),
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(20)),
                                  ),
                                  timeOut == false
                                      ? ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: questions.length,
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                for (int i = 0;
                                                    i <
                                                        questions[index]
                                                            .answer!
                                                            .length;
                                                    i++)
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: ScreenUtil()
                                                            .setHeight(16),
                                                        left: ScreenUtil()
                                                            .setWidth(16),
                                                        right: ScreenUtil()
                                                            .setWidth(16)),
                                                    child: widgetButton(
                                                        widgetText(
                                                            questions[index]
                                                                .answer!
                                                                .keys
                                                                .toList()[i],
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: ScreenUtil()
                                                                .setSp(16),
                                                            align:
                                                                TextAlign.left,
                                                            color: Colors.black),
                                                        () {
                                                      setState(() {
                                                        isPressed = true;
                                                        currentIndex = i;
                                                        answerPick =
                                                            questions[index]
                                                                .answer!
                                                                .entries
                                                                .toList()[i]
                                                                .key
                                                                .toString();
                                                        for (int c = 0;
                                                            c <
                                                                questions[index]
                                                                    .answer!
                                                                    .length;
                                                            c++) {
                                                          if (questions[index]
                                                                  .answer!
                                                                  .entries
                                                                  .toList()[c]
                                                                  .value ==
                                                              true) {
                                                            correctAnswer =
                                                                questions[index]
                                                                    .answer!
                                                                    .entries
                                                                    .toList()[c]
                                                                    .key;
                                                          }
                                                        }
                                                      });
                                                    },
                                                        height: 56.0,
                                                        radius: 20.0,
                                                        paddingBtn: EdgeInsets.only(
                                                            left: ScreenUtil()
                                                                .setWidth(24)),
                                                        colorBorder:
                                                            ColorsHelpers.grey5,
                                                        color: isPressed
                                                            ? currentIndex == i
                                                                ? isSelected
                                                                : isUnselected
                                                            : btnColor,
                                                        widthBorder: 1.0,
                                                        align: Alignment
                                                            .centerLeft,
                                                        width:
                                                            MediaQuery.of(context).size.width),
                                                  ),
                                              ],
                                            );
                                          },
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: ScreenUtil()
                                                      .setWidth(16)),
                                              child: widgetText(
                                                  'SELECTED ANSWER',
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1.5,
                                                  color: ColorsHelpers.grey2),
                                            ),
                                            answerPick != correctAnswer
                                                ? Container(
                                                    height: ScreenUtil()
                                                        .setHeight(56),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding: EdgeInsets.only(
                                                        left: ScreenUtil()
                                                            .setWidth(24)),
                                                    margin: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setHeight(8),
                                                        left: ScreenUtil()
                                                            .setWidth(16),
                                                        right: ScreenUtil()
                                                            .setWidth(16)),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 2,
                                                            color: Colors.red),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(16),
                                                        )),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        widgetText(answerPick,
                                                            color: Colors.red,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(16),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              right:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          16)),
                                                          child: const Icon(
                                                            Icons.close,
                                                            color: Colors.red,
                                                            size: 24,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : Container(
                                                    height: ScreenUtil()
                                                        .setHeight(56),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding: EdgeInsets.only(
                                                        left: ScreenUtil()
                                                            .setWidth(24)),
                                                    margin: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setHeight(8),
                                                        left: ScreenUtil()
                                                            .setWidth(16),
                                                        right: ScreenUtil()
                                                            .setWidth(16)),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            ColorsHelpers.green,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(16),
                                                        )),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        widgetText(
                                                            correctAnswer,
                                                            color: Colors.white,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(16),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              right:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          16)),
                                                          child: const Icon(
                                                            Icons.check,
                                                            color: Colors.white,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left:
                                                      ScreenUtil().setWidth(16),
                                                  top: ScreenUtil()
                                                      .setHeight(24)),
                                              child: widgetText(
                                                  'CORRECT ANSWER',
                                                  letterSpacing: 1.5,
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorsHelpers.grey2),
                                            ),
                                            Container(
                                              height:
                                                  ScreenUtil().setHeight(56),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil()
                                                      .setWidth(24)),
                                              margin: EdgeInsets.only(
                                                  top:
                                                      ScreenUtil().setHeight(8),
                                                  left:
                                                      ScreenUtil().setWidth(16),
                                                  right: ScreenUtil()
                                                      .setWidth(16)),
                                              decoration: BoxDecoration(
                                                  color: ColorsHelpers.green,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(16),
                                                  )),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  widgetText(correctAnswer,
                                                      color: Colors.white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(16),
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: ScreenUtil()
                                                            .setWidth(16)),
                                                    child: const Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                      size: 24,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left:
                                                      ScreenUtil().setWidth(16),
                                                  top: ScreenUtil()
                                                      .setHeight(24)),
                                              child: widgetText('EXPLANATION ',
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1.5,
                                                  color: ColorsHelpers.grey2),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left:
                                                      ScreenUtil().setWidth(16),
                                                  right:
                                                      ScreenUtil().setWidth(16),
                                                  top: ScreenUtil()
                                                      .setHeight(24)),
                                              child: widgetText(
                                                  'Southampton\'s Sadio Mané has scored the fastest hat-trick in Premier League history in just two minutes and 56 seconds against Aston Villa on Saturday. ',
                                                  fontSize:
                                                      ScreenUtil().setSp(16),
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black),
                                            ),
                                            widgetButton(
                                                widgetText('Next',
                                                    fontSize:
                                                        ScreenUtil().setSp(16),
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white), () {
                                              setState(() {
                                                isStep1 = true;
                                                timeOut = false;
                                                startTimer(isStep: isStep1);
                                              });
                                            },
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: ScreenUtil()
                                                    .setHeight(56.0),
                                                margin: EdgeInsets.only(
                                                  top: ScreenUtil()
                                                      .setHeight(30),
                                                  right:
                                                      ScreenUtil().setWidth(16),
                                                  left:
                                                      ScreenUtil().setWidth(16),
                                                ),
                                                radius: 20.0)
                                          ],
                                        )
                                ],
                              )
                            : isStep2 == false
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  top: ScreenUtil()
                                                      .setHeight(32)),
                                              child: SvgPicture.asset(
                                                  Images.illustrationKey))),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(32),
                                            left: ScreenUtil().setWidth(16),
                                            bottom: ScreenUtil().setHeight(8)),
                                        child: widgetText('QUESTION 4 OF 10',
                                            color: ColorsHelpers.grey2,
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(8),
                                            left: ScreenUtil().setWidth(16),
                                            right: ScreenUtil().setWidth(16),
                                            bottom: ScreenUtil().setHeight(24)),
                                        child: widgetText(
                                            'Theodorus of Samos is the person who invented keys?',
                                            fontWeight: FontWeight.w500,
                                            fontSize: ScreenUtil().setSp(20)),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(24),
                                            left: ScreenUtil().setWidth(16),
                                            right: ScreenUtil().setWidth(16)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            widgetButton(
                                                widgetText('False',
                                                    fontSize:
                                                        ScreenUtil().setSp(16),
                                                    fontWeight:
                                                        FontWeight.w500),
                                                () {},
                                                width:
                                                    ScreenUtil().setWidth(146),
                                                height:
                                                    ScreenUtil().setHeight(56),
                                                color: ColorsHelpers.red2,
                                                radius: 20.0),
                                            widgetButton(
                                                widgetText('True',
                                                    fontSize:
                                                        ScreenUtil().setSp(16),
                                                    fontWeight:
                                                        FontWeight.w500),
                                                () {},
                                                width:
                                                    ScreenUtil().setWidth(146),
                                                height:
                                                    ScreenUtil().setHeight(56),
                                                color: ColorsHelpers.green,
                                                radius: 20.0),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : isStep3 == false
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(32),
                                                left: ScreenUtil().setWidth(16),
                                                bottom:
                                                    ScreenUtil().setHeight(8)),
                                            child: widgetText(
                                                'QUESTION 5 OF 10',
                                                color: ColorsHelpers.grey2,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(8),
                                                left: ScreenUtil().setWidth(16),
                                                right:
                                                    ScreenUtil().setWidth(16),
                                                bottom:
                                                    ScreenUtil().setHeight(24)),
                                            child: widgetText(
                                                'Who are three players share the record for most Premier League red cards (8)?',
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    ScreenUtil().setSp(20)),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: ScreenUtil().setWidth(16),
                                                right:
                                                    ScreenUtil().setWidth(16)),
                                            child: Card(
                                                elevation: 0,
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
                                                  side: BorderSide(
                                                    color: ColorsHelpers.grey5,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: ScreenUtil()
                                                          .setWidth(24),
                                                      top: ScreenUtil()
                                                          .setHeight(16)),
                                                  child: const TextField(
                                                    maxLines: 8,
                                                    decoration: InputDecoration
                                                        .collapsed(
                                                            hintText:
                                                                "Write your answer"),
                                                  ),
                                                )),
                                          )
                                        ],
                                      )
                                    : isStep3 == true && isStep4 == false
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setHeight(32),
                                                    left: ScreenUtil()
                                                        .setWidth(16),
                                                    bottom: ScreenUtil()
                                                        .setHeight(8)),
                                                child: widgetText(
                                                    'QUESTION 6 OF 10',
                                                    color: ColorsHelpers.grey2,
                                                    fontSize:
                                                        ScreenUtil().setSp(14),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setHeight(8),
                                                    left: ScreenUtil()
                                                        .setWidth(16),
                                                    right: ScreenUtil()
                                                        .setWidth(16),
                                                    bottom: ScreenUtil()
                                                        .setHeight(10)),
                                                child: widgetText(
                                                    'How to pronounce Wojciech Szczesny?',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        ScreenUtil().setSp(20)),
                                              ),
                                              timeOut == false
                                                  ? Center(
                                                      child: !recorder
                                                              .isRecording
                                                          ? Column(
                                                              children: [
                                                                ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                            backgroundColor: ColorsHelpers
                                                                                .primaryColor,
                                                                            minimumSize: const Size(
                                                                                88, 88),
                                                                            elevation:
                                                                                0,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(50),
                                                                            )),
                                                                    onPressed:
                                                                        () async {
                                                                      if (recorder
                                                                          .isRecording) {
                                                                        await stop();
                                                                      } else {
                                                                        recorded =
                                                                            true;
                                                                        await record();
                                                                      }
                                                                      Future.delayed(
                                                                          Duration(
                                                                              milliseconds: durationTime),
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          stop();
                                                                        });
                                                                      });
                                                                    },
                                                                    child: SvgPicture
                                                                        .asset(Images
                                                                            .micIcon)),
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: ScreenUtil()
                                                                          .setHeight(
                                                                              16)),
                                                                  child: widgetText(
                                                                      'Hold to speak',
                                                                      fontSize: ScreenUtil()
                                                                          .setSp(
                                                                              16),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: ColorsHelpers
                                                                          .grey2),
                                                                ),
                                                              ],
                                                            )
                                                          : const Musicvisualizer())
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              top: ScreenUtil()
                                                                  .setHeight(
                                                                      32),
                                                              left: ScreenUtil()
                                                                  .setWidth(16),
                                                              bottom:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          8)),
                                                          child: widgetText(
                                                              'VOICE ANSWER',
                                                              color:
                                                                  ColorsHelpers
                                                                      .grey2,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          14),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: ScreenUtil()
                                                                .setWidth(16),
                                                            right: ScreenUtil()
                                                                .setWidth(16),
                                                          ),
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: ScreenUtil()
                                                              .setHeight(56),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              color:
                                                                  ColorsHelpers
                                                                      .green),
                                                          padding: EdgeInsets.only(
                                                              left: ScreenUtil()
                                                                  .setWidth(23),
                                                              right:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          16)),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    if (isPlaying) {
                                                                      // await audioPlayer
                                                                      //     .pause();
                                                                    } else {
                                                                      String
                                                                          file =
                                                                          fileAudio
                                                                              .toString();
                                                                      // await audioPlayer
                                                                      //     .play(
                                                                      //         file);
                                                                      // await audioPlayer
                                                                      //     .resume();
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .play_arrow,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 24,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 32,
                                                                  width: 32,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      color: const Color
                                                                              .fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          0.3)),
                                                                  child:
                                                                      const Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                )
                                                              ]),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              top: ScreenUtil()
                                                                  .setHeight(
                                                                      32),
                                                              left: ScreenUtil()
                                                                  .setWidth(16),
                                                              bottom:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          8)),
                                                          child: widgetText(
                                                              'EXPLANATION',
                                                              color:
                                                                  ColorsHelpers
                                                                      .grey2,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          14),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              left: ScreenUtil()
                                                                  .setWidth(16),
                                                              right:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          16),
                                                              top: ScreenUtil()
                                                                  .setHeight(
                                                                      24)),
                                                          child: widgetText(
                                                              'Pronunciation	English: Wojciech Szczęsny (listen)',
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          16),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              left: ScreenUtil()
                                                                  .setWidth(16),
                                                              right:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          16),
                                                              top: ScreenUtil()
                                                                  .setHeight(
                                                                      24)),
                                                          child: widgetText(
                                                              'Gender:	male',
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          16),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              left: ScreenUtil()
                                                                  .setWidth(16),
                                                              right:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          16),
                                                              top: ScreenUtil()
                                                                  .setHeight(
                                                                      24)),
                                                          child: widgetText(
                                                              'Word/name	origin: Polish',
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          16),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        widgetButton(
                                                            widgetText('Next',
                                                                fontSize: ScreenUtil()
                                                                    .setSp(16),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors.white),
                                                            () {
                                                          setState(() {
                                                            isStep4 = true;
                                                            timeOut = false;
                                                            startTimer(
                                                                isStep:
                                                                    isStep4);
                                                          });
                                                        },
                                                            width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width,
                                                            height: ScreenUtil()
                                                                .setHeight(
                                                                    56.0),
                                                            margin: EdgeInsets.only(
                                                                top: ScreenUtil()
                                                                    .setHeight(70),
                                                                right: ScreenUtil().setWidth(16),
                                                                left: ScreenUtil().setWidth(16)),
                                                            radius: 20.0)
                                                      ],
                                                    )
                                            ],
                                          )
                                        : isStep5 == false &&
                                                isStep4 == true &&
                                                isStep3 == true
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setHeight(32),
                                                        left: ScreenUtil()
                                                            .setWidth(16),
                                                        bottom: ScreenUtil()
                                                            .setHeight(8)),
                                                    child: widgetText(
                                                        'QUESTION 7 OF 10',
                                                        color:
                                                            ColorsHelpers.grey2,
                                                        fontSize: ScreenUtil()
                                                            .setSp(14),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setHeight(8),
                                                        left: ScreenUtil()
                                                            .setWidth(16),
                                                        right: ScreenUtil()
                                                            .setWidth(16),
                                                        bottom: ScreenUtil()
                                                            .setHeight(24)),
                                                    child: widgetText(
                                                        'Which three players shared the Premier League Golden Boot in 2018-19?',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: ScreenUtil()
                                                            .setSp(20)),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              2,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount: 4,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                            padding: EdgeInsets.only(
                                                                left: ScreenUtil()
                                                                    .setWidth(
                                                                        17)),
                                                            margin: EdgeInsets.only(
                                                                bottom:
                                                                    ScreenUtil()
                                                                        .setHeight(
                                                                            16),
                                                                left: ScreenUtil()
                                                                    .setWidth(
                                                                        16),
                                                                right: ScreenUtil()
                                                                    .setWidth(
                                                                        16)),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isChecked![
                                                                      index]
                                                                  ? ColorsHelpers
                                                                      .grey5
                                                                  : Colors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color:
                                                                      ColorsHelpers
                                                                          .grey5),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              ScreenUtil().setHeight(7)),
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            24,
                                                                        margin: EdgeInsets.only(
                                                                            right:
                                                                                ScreenUtil().setWidth(15)),
                                                                        child:
                                                                            Checkbox(
                                                                          value:
                                                                              isChecked![index],
                                                                          activeColor:
                                                                              ColorsHelpers.primaryColor,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                                                          onChanged:
                                                                              (bool? value) {
                                                                            setState(() {
                                                                              if (value == true) {
                                                                              } else {}

                                                                              isChecked![index] = value!;
                                                                            });
                                                                          },
                                                                        ),
                                                                      ),
                                                                      widgetText(
                                                                          listCandidate[
                                                                              index],
                                                                          fontSize: ScreenUtil().setSp(
                                                                              16),
                                                                          fontWeight: isChecked![index]
                                                                              ? FontWeight.w500
                                                                              : FontWeight.w400)
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      )),
                                                ],
                                              )
                                            : isStep5 == true &&
                                                    isStep6 == false
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: ScreenUtil()
                                                                .setHeight(32),
                                                            left: ScreenUtil()
                                                                .setWidth(16),
                                                            bottom: ScreenUtil()
                                                                .setHeight(8)),
                                                        child: widgetText(
                                                            'QUESTION 8 OF 10',
                                                            color: ColorsHelpers
                                                                .grey2,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(14),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: ScreenUtil()
                                                                .setHeight(8),
                                                            left: ScreenUtil()
                                                                .setWidth(16),
                                                            right: ScreenUtil()
                                                                .setWidth(16),
                                                            bottom: ScreenUtil()
                                                                .setHeight(24)),
                                                        child: widgetText(
                                                            'What is the best club in England?',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(20)),
                                                      ),
                                                      SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              2,
                                                          child:
                                                              ListView.builder(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                listClub.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    isVoted![
                                                                            index] =
                                                                        true;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets.only(
                                                                      bottom: ScreenUtil()
                                                                          .setHeight(
                                                                              16),
                                                                      left: ScreenUtil()
                                                                          .setWidth(
                                                                              16),
                                                                      right: ScreenUtil()
                                                                          .setWidth(
                                                                              16)),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    border: Border.all(
                                                                        width:
                                                                            2,
                                                                        color: ColorsHelpers
                                                                            .grey5),
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            ScreenUtil().setHeight(46),
                                                                        padding:
                                                                            EdgeInsets.zero,
                                                                        child:
                                                                            Stack(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          children: [
                                                                            isVoted![index]
                                                                                ? SizedBox(
                                                                                    width: MediaQuery.of(context).size.width,
                                                                                    child: LinearPercentIndicator(
                                                                                      backgroundColor: Colors.white,
                                                                                      animation: true,
                                                                                      animationDuration: 1000,
                                                                                      lineHeight: 56,
                                                                                      restartAnimation: true,
                                                                                      progressColor: ColorsHelpers.primaryColor.withOpacity(0.2),
                                                                                      barRadius: const Radius.circular(20),
                                                                                      percent: 0.9,
                                                                                      padding: EdgeInsets.zero,
                                                                                    ),
                                                                                  )
                                                                                : Container(),
                                                                            Positioned(
                                                                                left: 16,
                                                                                child: widgetText(listClub[index], fontSize: ScreenUtil().setSp(16), fontWeight: isVoted![index] ? FontWeight.w500 : FontWeight.w400)),
                                                                            isVoted![index]
                                                                                ? Positioned(right: 16, child: widgetText('92%', color: ColorsHelpers.primaryColor, fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w500))
                                                                                : Container()
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          )),
                                                    ],
                                                  )
                                                : isStep6 == true &&
                                                        isStep5 == true
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Center(
                                                              child: Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: ScreenUtil()
                                                                          .setHeight(
                                                                              32)),
                                                                  child: SvgPicture
                                                                      .asset(Images
                                                                          .illustrationDrone))),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                top: ScreenUtil()
                                                                    .setHeight(
                                                                        32),
                                                                left: ScreenUtil()
                                                                    .setWidth(
                                                                        16),
                                                                bottom:
                                                                    ScreenUtil()
                                                                        .setHeight(
                                                                            8)),
                                                            child: widgetText(
                                                                'QUESTION 9 OF 10',
                                                                color:
                                                                    ColorsHelpers
                                                                        .grey2,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            14),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                top: ScreenUtil()
                                                                    .setHeight(
                                                                        8),
                                                                left: ScreenUtil()
                                                                    .setWidth(
                                                                        16),
                                                                right:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            16),
                                                                bottom: ScreenUtil()
                                                                    .setHeight(
                                                                        24)),
                                                            child: widgetText(
                                                                'What does UAV stand for drone?',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            20)),
                                                          ),
                                                          Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            margin: EdgeInsets.only(
                                                                left: ScreenUtil()
                                                                    .setWidth(
                                                                        16),
                                                                right: ScreenUtil()
                                                                    .setWidth(
                                                                        16)),
                                                            child:
                                                                TextFormField(
                                                              readOnly: true,
                                                              onTap: () {},
                                                              controller:
                                                                  textFieldController,
                                                              decoration:
                                                                  InputDecoration(
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              2,
                                                                          color:
                                                                              ColorsHelpers.grey5),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              2,
                                                                          color:
                                                                              ColorsHelpers.grey5),
                                                                ),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.0)),
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                filled: true,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: ScreenUtil()
                                                                      .setWidth(
                                                                          19),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 200,
                                                              child: ChipsChoice<
                                                                  String>.multiple(
                                                                value: tags,
                                                                onChanged:
                                                                    ((value) =>
                                                                        setState(
                                                                            () {
                                                                          tags =
                                                                              value;
                                                                          displayString =
                                                                              tags.join(' ');
                                                                          textFieldController.text =
                                                                              displayString;
                                                                        })),
                                                                choiceItems: C2Choice.listFrom(
                                                                    source:
                                                                        options,
                                                                    value:
                                                                        (i, v) =>
                                                                            v,
                                                                    label:
                                                                        (i, v) =>
                                                                            v),
                                                                choiceStyle: C2ChoiceStyle(
                                                                    labelStyle: const TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .w400),
                                                                    showCheckmark:
                                                                        false,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    color: Colors
                                                                        .black,
                                                                    borderColor:
                                                                        ColorsHelpers
                                                                            .grey5,
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            16))),
                                                                wrapped: true,
                                                                choiceActiveStyle: C2ChoiceStyle(
                                                                    labelStyle: const TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .w500),
                                                                    showCheckmark:
                                                                        false,
                                                                    avatarBorderColor:
                                                                        Colors
                                                                            .red,
                                                                    backgroundColor: ColorsHelpers
                                                                        .primaryColor
                                                                        .withOpacity(
                                                                            0.2),
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            16))),
                                                                textDirection:
                                                                    TextDirection
                                                                        .ltr,
                                                              )),
                                                        ],
                                                      )
                                                    : Container()
                      ],
                    ),
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.21,
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(24),
                      bottom: ScreenUtil().setHeight(0),
                      left: ScreenUtil().setWidth(8),
                      right: ScreenUtil().setWidth(8)),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      color: Colors.white),
                  child: const Center(child: CircularProgressIndicator()))
        ]),
      ),
    );
  }
}
