import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quizgram/screens/live_quiz_screen/review_quiz_screen.dart';
import 'package:quizgram/screens/quiz/components/to_review_button.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:quizgram/utils/images.dart';
import 'package:quizgram/utils/widget_assets.dart';

class QuizChooseCategoryScreen extends StatefulWidget {
  const QuizChooseCategoryScreen({Key? key}) : super(key: key);

  @override
  QuizChooseCategoryState createState() => QuizChooseCategoryState();
}

class QuizChooseCategoryState extends State<QuizChooseCategoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsHelpers.primaryColor,
        elevation: 0,
        title: widgetText(
          'Diagnostik testlar',
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: ScreenUtil().setSp(24),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(24.0)),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(24)),
            child: const BackButton(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(16),
          bottom: ScreenUtil().setHeight(8),
          left: ScreenUtil().setWidth(8),
          right: ScreenUtil().setWidth(8),
        ),
        color: ColorsHelpers.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(8),
                    bottom: ScreenUtil().setHeight(16),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(32)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.to(ReviewQuizScren());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorsHelpers.grey5,
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setSp(20))),
                                    alignment: Alignment.center,
                                    width: ((MediaQuery.of(context).size.width /
                                            2) -
                                        ScreenUtil().setWidth(32)),
                                    margin: EdgeInsets.all(
                                        ScreenUtil().setWidth(8)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(16),
                                        bottom: ScreenUtil().setHeight(16),
                                      ),
                                      child: Column(
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth:
                                                  ScreenUtil().setWidth(48),
                                              maxHeight:
                                                  ScreenUtil().setWidth(48),
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              padding: EdgeInsets.all(
                                                  ScreenUtil().setWidth(9)),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .setSp(16))),
                                              child: SvgPicture.asset(
                                                Images.mathIcon,
                                                color:
                                                    ColorsHelpers.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(8),
                                                bottom:
                                                    ScreenUtil().setHeight(2)),
                                            child: widgetText(
                                              "Prezident",
                                              color: ColorsHelpers.primaryColor,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          widgetText(
                                            'maktabi',
                                            color: ColorsHelpers.primaryColor,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorsHelpers.grey5,
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setSp(20))),
                                    alignment: Alignment.center,
                                    width: ((MediaQuery.of(context).size.width /
                                            2) -
                                        ScreenUtil().setWidth(32)),
                                    margin: EdgeInsets.all(
                                        ScreenUtil().setWidth(8)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(16),
                                        bottom: ScreenUtil().setHeight(16),
                                      ),
                                      child: Column(
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth:
                                                  ScreenUtil().setWidth(48),
                                              maxHeight:
                                                  ScreenUtil().setWidth(48),
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              padding: EdgeInsets.all(
                                                  ScreenUtil().setWidth(9)),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .setSp(16))),
                                              child: SvgPicture.asset(
                                                Images.scienceIcon,
                                                color:
                                                    ColorsHelpers.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(8),
                                                bottom:
                                                    ScreenUtil().setHeight(2)),
                                            child: widgetText(
                                              "Abu Ali ibn Sino",
                                              color: ColorsHelpers.primaryColor,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          widgetText(
                                            'maktabi',
                                            color: ColorsHelpers.primaryColor,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorsHelpers.grey5,
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setSp(20))),
                                    alignment: Alignment.center,
                                    width: ((MediaQuery.of(context).size.width /
                                        2) -
                                        ScreenUtil().setWidth(32)),
                                    margin: EdgeInsets.all(
                                        ScreenUtil().setWidth(8)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(16),
                                        bottom: ScreenUtil().setHeight(16),
                                      ),
                                      child: Column(
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth:
                                              ScreenUtil().setWidth(48),
                                              maxHeight:
                                              ScreenUtil().setWidth(48),
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              padding: EdgeInsets.all(
                                                  ScreenUtil().setWidth(9)),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenUtil()
                                                          .setSp(16))),
                                              child: SvgPicture.asset(
                                                Images.historyIcon,
                                                color:
                                                ColorsHelpers.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(8),
                                                bottom:
                                                ScreenUtil().setHeight(2)),
                                            child: widgetText(
                                              "Blok testlar",
                                              color: ColorsHelpers.primaryColor,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          widgetText(
                                            'ID orqali',
                                            color: ColorsHelpers.primaryColor,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorsHelpers.grey5,
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setSp(20))),
                                    alignment: Alignment.center,
                                    width: ((MediaQuery.of(context).size.width /
                                        2) -
                                        ScreenUtil().setWidth(32)),
                                    margin: EdgeInsets.all(
                                        ScreenUtil().setWidth(8)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(16),
                                        bottom: ScreenUtil().setHeight(16),
                                      ),
                                      child: Column(
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth:
                                              ScreenUtil().setWidth(48),
                                              maxHeight:
                                              ScreenUtil().setWidth(48),
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              padding: EdgeInsets.all(
                                                  ScreenUtil().setWidth(9)),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenUtil()
                                                          .setSp(16))),
                                              child: SvgPicture.asset(
                                                Images.techIcon,
                                                color:
                                                ColorsHelpers.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(8),
                                                bottom:
                                                ScreenUtil().setHeight(2)),
                                            child: widgetText(
                                              "Axborot",
                                              color: ColorsHelpers.primaryColor,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          widgetText(
                                            'texnologiyalari',
                                            color: ColorsHelpers.primaryColor,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorsHelpers.grey5,
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setSp(20))),
                                    alignment: Alignment.center,
                                    width: ((MediaQuery.of(context).size.width /
                                            2) -
                                        ScreenUtil().setWidth(32)),
                                    margin: EdgeInsets.all(
                                        ScreenUtil().setWidth(8)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(16),
                                        bottom: ScreenUtil().setHeight(16),
                                      ),
                                      child: Column(
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth:
                                                  ScreenUtil().setWidth(48),
                                              maxHeight:
                                                  ScreenUtil().setWidth(48),
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              padding: EdgeInsets.all(
                                                  ScreenUtil().setWidth(9)),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .setSp(16))),
                                              child: SvgPicture.asset(
                                                Images.artIcon,
                                                color:
                                                    ColorsHelpers.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(8),
                                                bottom:
                                                    ScreenUtil().setHeight(2)),
                                            child: widgetText(
                                              "Prezident maktabi",
                                              color: ColorsHelpers.primaryColor,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          widgetText(
                                            '10 Quizzies',
                                            color: ColorsHelpers.primaryColor,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorsHelpers.grey5,
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setSp(20))),
                                    alignment: Alignment.center,
                                    width: ((MediaQuery.of(context).size.width /
                                            2) -
                                        ScreenUtil().setWidth(32)),
                                    margin: EdgeInsets.all(
                                        ScreenUtil().setWidth(8)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(16),
                                        bottom: ScreenUtil().setHeight(16),
                                      ),
                                      child: Column(
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth:
                                                  ScreenUtil().setWidth(48),
                                              maxHeight:
                                                  ScreenUtil().setWidth(48),
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              padding: EdgeInsets.all(
                                                  ScreenUtil().setWidth(9)),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .setSp(16))),
                                              child: SvgPicture.asset(
                                                Images.travelIcon,
                                                color:
                                                    ColorsHelpers.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(8),
                                                bottom:
                                                    ScreenUtil().setHeight(2)),
                                            child: widgetText(
                                              "Prezident maktabi",
                                              color: ColorsHelpers.primaryColor,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          widgetText(
                                            '10 Quizzies',
                                            color: ColorsHelpers.primaryColor,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorsHelpers.grey5,
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setSp(20))),
                                    alignment: Alignment.center,
                                    width: ((MediaQuery.of(context).size.width /
                                            2) -
                                        ScreenUtil().setWidth(32)),
                                    margin: EdgeInsets.all(
                                        ScreenUtil().setWidth(8)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(16),
                                        bottom: ScreenUtil().setHeight(16),
                                      ),
                                      child: Column(
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth:
                                                  ScreenUtil().setWidth(48),
                                              maxHeight:
                                                  ScreenUtil().setWidth(48),
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              padding: EdgeInsets.all(
                                                  ScreenUtil().setWidth(9)),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .setSp(16))),
                                              child: SvgPicture.asset(
                                                Images.musicIcon,
                                                color:
                                                    ColorsHelpers.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(8),
                                                bottom:
                                                    ScreenUtil().setHeight(2)),
                                            child: widgetText(
                                              "Prezident maktabi",
                                              color: ColorsHelpers.primaryColor,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          widgetText(
                                            '10 Quizzies',
                                            color: ColorsHelpers.primaryColor,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorsHelpers.grey5,
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setSp(20))),
                                    alignment: Alignment.center,
                                    width: ((MediaQuery.of(context).size.width /
                                            2) -
                                        ScreenUtil().setWidth(32)),
                                    margin: EdgeInsets.all(
                                        ScreenUtil().setWidth(8)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(16),
                                        bottom: ScreenUtil().setHeight(16),
                                      ),
                                      child: Column(
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth:
                                                  ScreenUtil().setWidth(48),
                                              maxHeight:
                                                  ScreenUtil().setWidth(48),
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              padding: EdgeInsets.all(
                                                  ScreenUtil().setWidth(9)),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .setSp(16))),
                                              child: SvgPicture.asset(
                                                Images.sportIcon,
                                                color:
                                                    ColorsHelpers.primaryColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(8),
                                                bottom:
                                                    ScreenUtil().setHeight(2)),
                                            child: widgetText(
                                              "Prezident maktabi",
                                              color: ColorsHelpers.primaryColor,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          widgetText(
                                            '10 Quizzies',
                                            color: ColorsHelpers.primaryColor,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ]),
                          ],
                        ),
                      ),
                      // const ToReviewButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
