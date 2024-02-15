import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:quizgram/screens/olympics_screen/olympics_screen.dart';
import 'package:quizgram/screens/quiz/diagnostic_quizzes_screen.dart';
import 'package:quizgram/screens/update_app_screen/update_app.dart';
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
  var box = Hive.box('user');
  bool _isLoading = false;
  String _newsText = "";
  String _adUrl = "https://t.me/quizgramuz";
  bool _internetError = false;
  final PageController _pageController = PageController();
  late Timer _timer;
  int _currentPage = 0;
  List<String> _adUrls = [
    "https://mobile.idealquiz.uz/img/ad/home.png",
    "https://mobile.idealquiz.uz/img/ad/ad.png",
    "https://mobile.idealquiz.uz/img/ad/insta.png",
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _adUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
    getBalans();
  }

  Future<void> getBalans() async {
    var token = box.get('token');
    var phone = box.get('phone');
    var headers = {'Authorization': 'Bearer ${token}'};
    var request = http.MultipartRequest(
        'POST', Uri.parse(WebApiConstans.getBalansAndNews));
    request.fields.addAll({'phone': "${phone}"});

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var reponseData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final data = json.decode(reponseData);
      box.put('balans', "${data['balance']}");
      if(box.get('version') < data['version']){
        Get.offAll(UpdateAppScreen());
      }
      setState(() {
        _newsText = data['screenText'];
        _adUrl = data['ad'];
      });
    } else {
      setState(() {
        _internetError = true;
      });
    }
  }

  Future<void> _refresh() async {
    await getBalans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
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
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(60)),
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
                                    child: widgetText(
                                        'Balans: ${box.get('balans')} so\'m',
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(20),
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    Images.appLogo,
                                    width: ScreenUtil().setWidth(70),
                                  ))
                              // child: SvgPicture.asset(Images.avatar))
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse(_adUrl));
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white70,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: _adUrls.length,
                                itemBuilder: (context, index) {
                                  return Image.network(
                                    _adUrls[index],
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return const Center(
                                        child: Row(
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
                                        ),
                                      );
                                    },
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  );
                                },
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentPage = index;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(130),
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(24),
                              left: ScreenUtil().setWidth(24),
                              right: ScreenUtil().setWidth(24)),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                                    turns:
                                        const AlwaysStoppedAnimation(180 / 360),
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
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(15)),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(10)),
                                        child: widgetText('YANGILIK',
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontSize: ScreenUtil().setSp(14),
                                            letterSpacing: 5),
                                      ),
                                      Container(
                                        child: widgetText(_newsText,
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
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(24)),
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
                                widgetText('Bo\'limlar',
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(20),
                                    color: Colors.black),
                                widgetText('Barchisini ko\'rish',
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
                              child: listItem(
                                  Image.asset(Images.illustrationTrophy),
                                  'Olimpiadalar',
                                  'Musobaqalarda bellashing', () {
                                    // print(box.get('token'));
                                Get.to(Olympics());
                                // Get.to(LiveQuizScreen());
                              }, Colors.white, Colors.black,
                                  ColorsHelpers.grey2),
                            ),
                            listItem(
                                Image.asset(Images.quiz_section),
                                'Diagnostik testlar',
                                'Bilimingizni tekshiring',
                                () {
                                  Get.to(DiagnosticQuizzes());
                                },
                                Colors.white,
                                Colors.black,
                                ColorsHelpers.grey2),
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
      ),
      bottomNavigationBar: bottomBar(0),
    );
  }
}
