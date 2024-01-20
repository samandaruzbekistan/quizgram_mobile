import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizgram/screens/live_quiz_screen/live_quiz_screen.dart';
import 'package:quizgram/screens/live_quiz_screen/quiz_complete_screen.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:quizgram/utils/images.dart';
import 'package:quizgram/utils/widget_assets.dart';

class DetailQuizScreen extends StatefulWidget {
  const DetailQuizScreen({Key? key, required this.name, required this.quiz_count, required this.description}) : super(key: key);

  final String name;
  final int quiz_count;
  final String description;

  @override
  State<DetailQuizScreen> createState() => _DetailQuizScreenState();
}

class _DetailQuizScreenState extends State<DetailQuizScreen> {
  @override
  Widget build(BuildContext context) {
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
                                    widgetText('+100 points',
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
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(30)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    widgetButton(
                                        widgetText('Play Solo',
                                            fontWeight: FontWeight.w500,
                                            fontSize: ScreenUtil().setSp(16),
                                            color: ColorsHelpers.primaryColor),
                                        () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LiveQuizScreen()));
                                    },
                                        height: 56.0,
                                        width: 142.0,
                                        radius: 20.0,
                                        colorBorder: ColorsHelpers.secondLavender,
                                        color: Colors.white,
                                        widthBorder: 1.0),
                                    widgetButton(
                                      widgetText('Play with Friends',
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(16),
                                          color: Colors.white),
                                      () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const QuizCompleteScreen()));
                                      },
                                      height: 56.0,
                                      width: 200.0,
                                      radius: 20.0,
                                    ),
                                  ],
                                ),
                              )
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
