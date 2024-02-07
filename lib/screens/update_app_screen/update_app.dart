import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quizgram/screens/login_screen/login_screen.dart';
import 'package:quizgram/screens/sign_up_screen/sign_up_screen.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:quizgram/utils/images.dart';
import 'package:quizgram/utils/widget_assets.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateAppScreen extends StatefulWidget {
  const UpdateAppScreen({Key? key}) : super(key: key);

  @override
  State<UpdateAppScreen> createState() => _UpdateAppScreenState();
}

class _UpdateAppScreenState extends State<UpdateAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ColorsHelpers.primaryColor,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 56, top: 218),
                      child: SvgPicture.asset(Images.ovalBig),
                    ),
                    SvgPicture.asset(Images.ovalWithOutlineTop)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Images.ovalWithOutlineBottom),
                    Padding(
                      padding: const EdgeInsets.only(right: 80, bottom: 100),
                      child: SvgPicture.asset(Images.ovalMini),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(60)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      Images.appLogo,
                      height: ScreenUtil().setHeight(56),
                      width: ScreenUtil().setWidth(50),
                    ),
                  ),
                  Image.asset(
                    Images.appUpdate,
                    width: MediaQuery.of(context).size.width*0.4,
                    // height: 96,
                  ),

                ],
              ),
            ),
            Positioned(
              bottom: 50,
              left: 10,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(16),
                    right: ScreenUtil().setWidth(16)),
                height: ScreenUtil().setHeight(340),
                width: ScreenUtil().setWidth(343),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                      child: widgetText('Yangilanish mavjud',
                          fontSize: ScreenUtil().setSp(22),
                          letterSpacing: -1,
                          color: const Color.fromRGBO(0, 24, 51, 1)),
                    ),
                    Container(
                      child: widgetText(
                          'Ilovadan to\'liq holda foydalanish uchun avval ilovani yangilang',
                          fontSize: ScreenUtil().setSp(16),
                          color: const Color.fromRGBO(133, 132, 148, 1),
                          fontWeight: FontWeight.w400,
                          align: TextAlign.center),
                    ),
                    widgetButton(
                        widgetText('Yangilash', color: Colors.white, fontSize: ScreenUtil().setSp(18)),
                        width: ScreenUtil().setWidth(311),
                        height: ScreenUtil().setHeight(56),
                        radius: 20.0,
                        () {
                          if(Platform.isAndroid){
                            launchUrl(Uri.parse(WebApiConstans.googlePlay));
                          }
                        }),
                    widgetButton(
                        widgetText('Keyin', fontSize: ScreenUtil().setSp(18),
                            color: ColorsHelpers.primaryColor),
                        color: const Color.fromRGBO(239, 238, 252, 1),
                        width: ScreenUtil().setWidth(311),
                        height: ScreenUtil().setHeight(56),
                        radius: 20.0,
                        () => SystemNavigator.pop()),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
