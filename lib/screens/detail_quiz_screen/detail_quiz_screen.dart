import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:quizgram/controllers/olympic_api_controller.dart';
import 'package:quizgram/screens/invite_friend_screen/invite_friend_screen.dart';
import 'package:quizgram/screens/quiz/play_olympic_quiz.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:quizgram/utils/images.dart';
import 'package:quizgram/utils/widget_assets.dart';
import 'package:http/http.dart' as http;

import '../alerts/custom_alerts.dart';

class DetailQuizScreen extends StatefulWidget {
  const DetailQuizScreen(
      {Key? key,
      required this.olympicId,
      required this.amount,
      required this.name,
      required this.quiz_count,
      required this.description})
      : super(key: key);
  final String name;
  final int amount;
  final int olympicId;
  final int quiz_count;
  final String description;

  @override
  State<DetailQuizScreen> createState() => _DetailQuizScreenState();
}

class _DetailQuizScreenState extends State<DetailQuizScreen> {
  var box = Hive.box('user');
  bool _isLoading = true;
  bool _examState = false;
  bool _buyState = false;
  bool _complate = false;
  bool _api = false;

  Future<void> fetchData() async {
    var token = box.get('token');
    var id = box.get('id');
    print(id);
    var headers = {'Authorization': 'Bearer ${token}'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://mobile.quizgram.uz/api/checkBuyOlympic'));
    request.fields
        .addAll({'user_id': "${id}", 'exam_day_id': "${widget.olympicId}"});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final data = json.decode(res);
      if (data['exam_state'] == false) {
        if (data['state'] == false) {
          setState(() {
            _isLoading = false;
            _examState = false;
            _buyState = false;
            _complate = false;
          });
        } else if ((data['state'] == true) && (data['complate'] == true)) {
          setState(() {
            _isLoading = false;
            _examState = false;
            _buyState = true;
            _complate = true;
          });
        } else {
          setState(() {
            _isLoading = false;
            _examState = false;
            _buyState = true;
            _complate = false;
          });
        }
      } else {
        if (data['state'] == false) {
          setState(() {
            _isLoading = false;
            _examState = true;
            _buyState = false;
            _complate = false;
          });
        } else if ((data['state'] == true) && (data['complate'] == true)) {
          setState(() {
            _isLoading = false;
            _examState = true;
            _buyState = true;
            _complate = true;
          });
        } else {
          setState(() {
            _isLoading = false;
            _examState = true;
            _buyState = true;
            _complate = false;
          });
        }
      }
    } else {
      setState(() {
        _isLoading = false;
        _api = true;
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OlympicApiController apiController = OlympicApiController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: ColorsHelpers.primaryColor,
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 50,
                child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(180 / 360),
                    child: SvgPicture.asset(
                      Images.ovalWithOutlineBottomOnboarding,
                      height: ScreenUtil().setHeight(200),
                      width: ScreenUtil().setWidth(200),
                      fit: BoxFit.fitHeight,
                    )),
              ),
              Positioned(top: 250, child: Image.asset(Images.ovalTwoBig)),
              Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(42),
                    bottom: ScreenUtil().setHeight(20)),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset(
                      Images.competition,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: ScreenUtil().setHeight(480),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(24),
                          right: ScreenUtil().setWidth(16),
                          left: ScreenUtil().setWidth(16)),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                          color: Colors.white),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(8)),
                              child: widgetText('OLIMPIADA',
                                  color: ColorsHelpers.grey2,
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2),
                            ),
                            widgetText('${widget.name}',
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(20),
                                color: Colors.black),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: ScreenUtil().setHeight(64),
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(16)),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: ColorsHelpers.grey5,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(Images.iconQuestionMark),
                                  widgetText('${widget.quiz_count} savollar',
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(14),
                                      color: Colors.black),
                                  Container(
                                    height: 32,
                                    width: 1,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: const [0.1, 0.5, 0.9],
                                        colors: [
                                          Colors.grey.withOpacity(0.1),
                                          Colors.grey.withOpacity(0.5),
                                          Colors.grey.withOpacity(0.1),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SvgPicture.asset(Images.iconPuzzle),
                                  widgetText('${widget.amount} so\'m',
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(14),
                                      color: Colors.black),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(24),
                                  bottom: ScreenUtil().setHeight(16)),
                              child: widgetText('TARIF',
                                  color: ColorsHelpers.grey2,
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2),
                            ),
                            widgetText(
                              widget.description,
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.w400,
                              // overflow: TextOverflow.ellipsis
                            ),
                            Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(30)),
                                child: _isLoading
                                    ? CircularProgressIndicator()
                                    : _api
                                        ? const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons
                                                  .signal_wifi_connected_no_internet_4),
                                              Text(
                                                "  Internetga ulanish mavjud emas",
                                                style: TextStyle(fontSize: 16),
                                              )
                                            ],
                                          )
                                        : _examState
                                            ? _buyState
                                                ? _complate
                                                    ? Text('Natija')
                                                    : widgetButton(
                                                        widgetText(
                                                            'Boshlash',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(16),
                                                            color:
                                                                Colors.white),
                                                        () {
                                                          // Get.to(LiveQuizScreen());
                                                          Get.to(PlayOlympicQuiz(examId: widget.olympicId,));
                                                        },
                                                        height: 56.0,
                                                        width: 200.0,
                                                        radius: 20.0,
                                                      )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      widgetButton(
                                                          widgetText(
                                                              'Sotib olish',
                                                              fontWeight: FontWeight
                                                                  .w500,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          16),
                                                              color:
                                                                  ColorsHelpers
                                                                      .primaryColor),
                                                          () async {
                                                        setState(() {
                                                          _isLoading = true;
                                                        });
                                                        var res =
                                                            await apiController
                                                                .buyExam(
                                                                    widget
                                                                        .olympicId,
                                                                    "");
                                                        if (res == 1) {
                                                          setState(() {
                                                            _isLoading = true;
                                                          });
                                                          buyAlert(context);
                                                        } else {
                                                          setState(() {
                                                            _isLoading = true;
                                                          });
                                                          balansErrorAlert(
                                                              context);
                                                        }
                                                      },
                                                          height: 56.0,
                                                          width: 142.0,
                                                          radius: 20.0,
                                                          colorBorder:
                                                              ColorsHelpers
                                                                  .secondLavender,
                                                          color: Colors.white,
                                                          widthBorder: 1.0),
                                                      widgetButton(
                                                        widgetText(
                                                            'Promokod orqali',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(16),
                                                            color:
                                                                Colors.white),
                                                        () {
                                                          Get.to(InviteFriendScreen(
                                                              olympicId: widget
                                                                  .olympicId));
                                                        },
                                                        height: 56.0,
                                                        width: 200.0,
                                                        radius: 20.0,
                                                      ),
                                                    ],
                                                  )
                                            : _buyState
                                                ? _complate
                                                    ? Text('Natija')
                                                    : Text(
                                                        "Imtixon yakunlangan siz ishtirok etmadingiz")
                                                : Text("Imtixon yakunlangan"))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
