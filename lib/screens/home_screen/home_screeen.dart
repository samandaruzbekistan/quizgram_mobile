import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quizgram/screens/detail_quiz_screen/detail_quiz_screen.dart';
import 'package:quizgram/screens/setting_screen/setting_screen.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:quizgram/utils/images.dart';
import 'package:quizgram/utils/widget_assets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Permission.camera.request().isGranted;
    requestMultiplePermissions();

    super.initState();
  }

  void requestMultiplePermissions() async {}

  void requestCameraPermission() async {
    /// status can either be: granted, denied, restricted or permanentlyDenied
    var status = await Permission.camera.status;
    if (status.isGranted) {
    } else if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      if (await Permission.camera.request().isGranted) {
        openAppSettings();
        // Either the permission was already granted before or the user just granted it.

      }
    }

    // You can can also directly ask the permission about its status.
    // if (await Permission.location.isRestricted) {
    //   // The OS restricts access, for example because of parental controls.
    // }
  }

  void getAdvertising(){

  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('user');
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.5, 0.5],
                  colors: [
                    ColorsHelpers.primaryColor,
                    Colors.white,
                  ],
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  color: ColorsHelpers.primaryColor,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(60)),
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(24),
                            right: ScreenUtil().setWidth(24)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person_outline,
                                      size: 20.0,
                                      color: ColorsHelpers.pinkAccent,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(8)),
                                      child: widgetText('${box.get('name')}',
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(12),
                                          color: ColorsHelpers.pinkAccent),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(5)),
                                  child: widgetText('Xush kelibsiz!',
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(24),
                                      color: Colors.white),
                                )
                              ],
                            ),
                            GestureDetector(
                                onTap: () {

                                },
                                child: Image.asset(Images.appLogo, width: ScreenUtil().setWidth(70),))
                                // child: SvgPicture.asset(Images.avatar))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          launchUrl(Uri.parse("https://mobile.quizgram.uz/ad"));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(24),
                            right: ScreenUtil().setWidth(24),
                            top: ScreenUtil().setHeight(24),
                          ),
                          height: ScreenUtil().setHeight(84),
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white70,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              "https://mobile.quizgram.uz/img/ad/ad.png",
                              fit: BoxFit.cover, // or BoxFit.fill, BoxFit.fitWidth, etc.
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                return const Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.signal_wifi_connected_no_internet_4),
                                      Text("  Internetga ulanish mavjud emas", style: TextStyle(fontSize: 16),)
                                    ],
                                  ),
                                );
                              },
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(232),
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(24),
                            left: ScreenUtil().setWidth(24),
                            right: ScreenUtil().setWidth(24)),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromRGBO(143, 136, 228, 1)),
                        child: Stack(
                          children: [
                            Positioned(
                                left: 0,
                                bottom: 0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20)),
                                  child: SvgPicture.asset(
                                    Images.ovalWithOutlineBottomHomeScreen,
                                    width: 160,
                                    height: 160,
                                  ),
                                )),
                            Positioned(
                                right: 1,
                                top: 0,
                                child: RotationTransition(
                                  turns: const AlwaysStoppedAnimation(180 / 360),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20)),
                                    child: SvgPicture.asset(
                                      Images.ovalWithOutlineBottomHomeScreen,
                                      width: 160,
                                      height: 160,
                                    ),
                                  ),
                                )),
                            Positioned(
                                left: 16,
                                top: 16,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20)),
                                  child: SvgPicture.asset(
                                    Images.person,
                                    height: ScreenUtil().setHeight(48),
                                    width: ScreenUtil().setWidth(48),
                                  ),
                                )),
                            Positioned(
                                right: ScreenUtil().setWidth(15),
                                bottom: ScreenUtil().setHeight(10),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20)),
                                  child: SvgPicture.asset(
                                    Images.personTwo,
                                    height: ScreenUtil().setHeight(56),
                                    width: ScreenUtil().setWidth(64),
                                  ),
                                )),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(40)),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: ScreenUtil().setHeight(16)),
                                      child: widgetText('YANGILIK',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: ScreenUtil().setSp(14),
                                          letterSpacing: 5),
                                    ),
                                    Container(
                                      child: widgetText(
                                          'Take part in challenges\nwith friends or other\nplayers',
                                          fontWeight: FontWeight.w500,
                                          align: TextAlign.center,
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(18)),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                        padding: const EdgeInsets.all(24),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(32),
                                topLeft: Radius.circular(32))),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widgetText('Live Quizzes',
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(20),
                                  color: Colors.black),
                              widgetText('See all',
                                  color: ColorsHelpers.primaryColor,
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w500)
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(16)),
                            child: listItem(SvgPicture.asset(Images.chart),
                                'Statistics Math Quiz', 'Math • 12 Quizzes', () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailQuizScreen()));
                            }, Colors.white, Colors.black, ColorsHelpers.grey2),
                          ),
                          listItem(SvgPicture.asset(Images.integers),
                              'Integers Quiz', 'Math • 10 Quizzes', () {
                            requestCameraPermission();
                          }, Colors.white, Colors.black, ColorsHelpers.grey2),
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomBar(0),
    );
  }
}
