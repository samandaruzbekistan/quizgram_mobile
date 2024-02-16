import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:quizgram/screens/profile_screen/paymentOrder.dart';
import 'package:quizgram/screens/setting_screen/setting_screen.dart';
import 'package:quizgram/utils/chart_series.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:quizgram/utils/images.dart';
import 'package:quizgram/utils/widget_assets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../bottom_navigation_bar.dart';
import '../discover_screen/discover_screen.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results>
    with TickerProviderStateMixin {




  @override
  Widget build(BuildContext context) {
    var box = Hive.box('user');
    var name = box.get('name');
    var gender = box.get('gender');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text("Mening natijalarim", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        color: ColorsHelpers.primaryColor,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              right: -50,
              top: -50,
              child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(120 / 360),
                  child: Image.asset(
                    Images.ovalTwoBig,
                    height: ScreenUtil().setHeight(200),
                    width: ScreenUtil().setWidth(200),
                  )),
            ),
            Positioned(
              left: -50,
              top: 100,
              child: Image.asset(
                Images.ovalTwoBig,
                height: ScreenUtil().setHeight(200),
                width: ScreenUtil().setWidth(200),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(80)),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(20),
                        left: ScreenUtil().setWidth(8),
                        right: ScreenUtil().setWidth(8)),
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32))),
                    child: Column(
                      children: [
                        Expanded(
                          child:SingleChildScrollView(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                // height: MediaQuery.of(context).size.height / 2,
                                margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(24),
                                  right: ScreenUtil().setWidth(24),
                                ),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Get.to(PaymentOrder());
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                                            color: ColorsHelpers.grey5),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: ScreenUtil().setWidth(44),
                                              height: ScreenUtil().setWidth(44),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              margin: EdgeInsets.all(ScreenUtil().setWidth(16)),
                                              child: Icon(
                                                Icons.tour_outlined,
                                                color: ColorsHelpers.primaryColor,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  widgetText(
                                                    'Olimpiadalar',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: ScreenUtil().setSp(16),
                                                  ),
                                                  Text(
                                                    'Barcha natijalar',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: ScreenUtil().setSp(14),
                                                        fontFamily: 'Rubik',
                                                        fontWeight: FontWeight.w400,
                                                        color: ColorsHelpers.grey2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsets.only(right: ScreenUtil().setWidth(16)),
                                              child: Icon(Icons.arrow_forward_ios,
                                                  size: ScreenUtil().setSp(20)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){

                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                                            color: ColorsHelpers.grey5),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: ScreenUtil().setWidth(44),
                                              height: ScreenUtil().setWidth(44),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              margin: EdgeInsets.all(ScreenUtil().setWidth(16)),
                                              padding: EdgeInsets.all(ScreenUtil().setWidth(6)),
                                              child: SvgPicture.asset(
                                                Images.mathIcon,
                                                color:
                                                ColorsHelpers.primaryColor,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  widgetText(
                                                    'Prezident maktabi',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: ScreenUtil().setSp(16),
                                                  ),
                                                  Text(
                                                    'Matematika, Ingliz tili',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: ScreenUtil().setSp(14),
                                                        fontFamily: 'Rubik',
                                                        fontWeight: FontWeight.w400,
                                                        color: ColorsHelpers.grey2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsets.only(right: ScreenUtil().setWidth(16)),
                                              child: Icon(Icons.arrow_forward_ios,
                                                  size: ScreenUtil().setSp(20)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){

                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                                            color: ColorsHelpers.grey5),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: ScreenUtil().setWidth(44),
                                              height: ScreenUtil().setWidth(44),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              margin: EdgeInsets.all(ScreenUtil().setWidth(16)),
                                              padding: EdgeInsets.all(ScreenUtil().setWidth(6)),
                                              child: SvgPicture.asset(
                                                Images.scienceIcon,
                                                color:
                                                ColorsHelpers.primaryColor,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  widgetText(
                                                    'Tabiiy fanlar',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: ScreenUtil().setSp(16),
                                                  ),
                                                  Text(
                                                    'Abu Ali ibn Sino maktabi',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: ScreenUtil().setSp(14),
                                                        fontFamily: 'Rubik',
                                                        fontWeight: FontWeight.w400,
                                                        color: ColorsHelpers.grey2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsets.only(right: ScreenUtil().setWidth(16)),
                                              child: Icon(Icons.arrow_forward_ios,
                                                  size: ScreenUtil().setSp(20)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){

                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                                            color: ColorsHelpers.grey5),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: ScreenUtil().setWidth(44),
                                              height: ScreenUtil().setWidth(44),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              margin: EdgeInsets.all(ScreenUtil().setWidth(16)),
                                              padding: EdgeInsets.all(ScreenUtil().setWidth(6)),
                                              child: SvgPicture.asset(
                                                Images.scienceIcon,
                                                color:
                                                ColorsHelpers.primaryColor,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  widgetText(
                                                    'MOCK testlar',
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: ScreenUtil().setSp(16),
                                                  ),
                                                  Text(
                                                    'Turk tili, IELTS',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: ScreenUtil().setSp(14),
                                                        fontFamily: 'Rubik',
                                                        fontWeight: FontWeight.w400,
                                                        color: ColorsHelpers.grey2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsets.only(right: ScreenUtil().setWidth(16)),
                                              child: Icon(Icons.arrow_forward_ios,
                                                  size: ScreenUtil().setSp(20)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomBar(2),
    );
  }
}
