import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quizgram/screens/setting_screen/setting_screen.dart';
import 'package:quizgram/utils/chart_series.dart';
import 'package:quizgram/utils/chart_widget.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:quizgram/utils/images.dart';
import 'package:quizgram/utils/widget_assets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../bottom_navigation_bar.dart';
import '../discover_screen/discover_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  TabController? _controller;
  int? _selectedItem = 0;
  final List<String> items = [
    'Daily',
    'Monthly',
    'Weekly',
    'Yearly',
  ];
  String? selectedValue;
  final badgeList = <String>[
    Images.badge1,
    Images.badge1,
    Images.badge1,
  ];
  final nbs = <int>[3, 4, 3];

  final List<ChartSeries> data = [
    ChartSeries(
      year: '3/10\nQuistions\nAnswered',
      developers: 20,
      barColor: charts.ColorUtil.fromDartColor(
          const Color.fromRGBO(255, 214, 221, 1)),
    ),
    ChartSeries(
      year: '8/10\nQuistions\nAnswered',
      developers: 80,
      barColor: charts.ColorUtil.fromDartColor(
          const Color.fromRGBO(196, 208, 251, 1)),
    ),
    ChartSeries(
      year: '6/10\nQuistions\nAnswered',
      developers: 60,
      barColor: charts.ColorUtil.fromDartColor(
          const Color.fromRGBO(169, 173, 243, 1)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller!.addListener(() {
      setState(() {
        _selectedItem = _controller!.index;
      });
    });

    _controller!.index = _selectedItem!;
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('user');
    var name = box.get('name');
    var gender = box.get('gender');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(
            color: Colors.white,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingScreen()));
              },
              child: Container(
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(24)),
                  child: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  )),
            )
          ],
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
                          top: ScreenUtil().setHeight(50),
                          left: ScreenUtil().setWidth(8),
                          right: ScreenUtil().setWidth(8)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32))),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(48),
                                bottom: ScreenUtil().setHeight(24)),
                            child: widgetText('${name}',
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(24),
                                color: Colors.black),
                          ),
                          // Container(
                          //   width: MediaQuery.of(context).size.width,
                          //   height: ScreenUtil().setHeight(101),
                          //   margin: EdgeInsets.only(
                          //       left: ScreenUtil().setWidth(16),
                          //       right: ScreenUtil().setWidth(16)),
                          //   decoration: BoxDecoration(
                          //       color: ColorsHelpers.primaryColor,
                          //       borderRadius: const BorderRadius.all(
                          //           Radius.circular(20))),
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Expanded(
                          //         flex: 1,
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             const Icon(
                          //               Icons.star_border,
                          //               color: Colors.white,
                          //               size: 24,
                          //             ),
                          //             Container(
                          //               margin: const EdgeInsets.only(
                          //                   top: 3, bottom: 3),
                          //               child: widgetText('POINTS',
                          //                   fontWeight: FontWeight.w500,
                          //                   fontSize: ScreenUtil().setSp(12),
                          //                   color:
                          //                       Colors.white.withOpacity(0.5),
                          //                   letterSpacing: 2),
                          //             ),
                          //             widgetText('590',
                          //                 color: Colors.white,
                          //                 fontWeight: FontWeight.w700,
                          //                 fontSize: ScreenUtil().setSp(16))
                          //           ],
                          //         ),
                          //       ),
                          //       Container(
                          //         height: 69,
                          //         width: 1,
                          //         decoration: BoxDecoration(
                          //           gradient: LinearGradient(
                          //             begin: Alignment.topCenter,
                          //             end: Alignment.bottomCenter,
                          //             stops: const [0.1, 0.5, 0.9],
                          //             colors: [
                          //               Colors.white.withOpacity(0.1),
                          //               Colors.white.withOpacity(0.5),
                          //               Colors.white.withOpacity(0.1),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //       Expanded(
                          //         flex: 1,
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             SvgPicture.asset(
                          //               Images.globe,
                          //               color: Colors.white,
                          //             ),
                          //             Container(
                          //               margin: const EdgeInsets.only(
                          //                   top: 3, bottom: 3),
                          //               child: widgetText('WORLD RANK',
                          //                   fontWeight: FontWeight.w500,
                          //                   fontSize: ScreenUtil().setSp(12),
                          //                   color:
                          //                       Colors.white.withOpacity(0.5),
                          //                   letterSpacing: 1),
                          //             ),
                          //             widgetText('#1,590',
                          //                 color: Colors.white,
                          //                 fontWeight: FontWeight.w700,
                          //                 fontSize: ScreenUtil().setSp(16))
                          //           ],
                          //         ),
                          //       ),
                          //       Container(
                          //         height: 69,
                          //         width: 1,
                          //         decoration: BoxDecoration(
                          //           gradient: LinearGradient(
                          //             begin: Alignment.topCenter,
                          //             end: Alignment.bottomCenter,
                          //             stops: const [0.1, 0.5, 0.9],
                          //             colors: [
                          //               Colors.white.withOpacity(0.1),
                          //               Colors.white.withOpacity(0.5),
                          //               Colors.white.withOpacity(0.1),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //       Expanded(
                          //         flex: 1,
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             SvgPicture.asset(
                          //               Images.rank,
                          //               color: Colors.white,
                          //             ),
                          //             Container(
                          //               margin: const EdgeInsets.only(
                          //                   top: 3, bottom: 3),
                          //               child: widgetText('LOCAL RANK',
                          //                   fontWeight: FontWeight.w500,
                          //                   fontSize: ScreenUtil().setSp(12),
                          //                   color:
                          //                       Colors.white.withOpacity(0.5),
                          //                   letterSpacing: 1),
                          //             ),
                          //             widgetText('#56',
                          //                 color: Colors.white,
                          //                 fontWeight: FontWeight.w700,
                          //                 fontSize: ScreenUtil().setSp(16))
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(16),
                            ),
                            child: TabBar(
                              controller: _controller,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: CircleTabIndicator(
                                  color: ColorsHelpers.primaryColor, radius: 4),
                              labelStyle: TextStyle(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w700),
                              unselectedLabelStyle: TextStyle(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400),
                              labelColor: ColorsHelpers.primaryColor,
                              unselectedLabelColor: ColorsHelpers.grey2,
                              labelPadding: EdgeInsets.zero,
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(15),
                                  right: ScreenUtil().setWidth(15)),
                              tabs: const [

                                Tab(
                                  text: 'Sozlamalar',
                                ),
                                Tab(
                                  text: 'Sertifikatlar',
                                ),
                              ],
                              onTap: (l) {},
                            ),
                          ),
                          Expanded(
                            child:
                                TabBarView(controller: _controller, children: [
                              SingleChildScrollView(
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(24),
                                      right: ScreenUtil().setWidth(24),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
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
                                                  Icons.person_outline_rounded,
                                                  color: ColorsHelpers.primaryColor,
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    widgetText(
                                                      'Malumotlarim',
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: ScreenUtil().setSp(16),
                                                    ),
                                                    Text(
                                                      'Ism, Familya, Raqam, Tashkilot',
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
                                        Container(
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
                                                  Icons.price_check,
                                                  color: ColorsHelpers.primaryColor,
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    widgetText(
                                                      'Xisobni to\'ldirish',
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: ScreenUtil().setSp(16),
                                                    ),
                                                    Text(
                                                      'Click, Payme, Uzum bank',
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
                                        GestureDetector(
                                          onTap: (){
                                            var box = Hive.box('user');
                                            box.clear();
                                            SystemNavigator.pop();
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
                                                    Icons.logout,
                                                    color: ColorsHelpers.red,
                                                  ),
                                                ),
                                                widgetText(
                                                  'Chiqish',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: ScreenUtil().setSp(16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Container(child: Text('serti'),)
                            ]),
                          )
                        ],
                      ),
                    ),
                    Container(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              gender == "female" ? Images.avatar : Images.avatar2,
                              width: 96,
                              height: 96,
                            ),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: Image.asset(
                                  Images.flagUzbekistan,
                                  width: 28,
                                  height: 28,
                                ))
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: bottomBar(3),
      ),
    );
  }
}
