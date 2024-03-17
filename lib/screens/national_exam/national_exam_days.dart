import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:quizgram/screens/national_exam/national_exam_detail.dart';
import 'package:quizgram/screens/olympics_screen/olympic_detail.dart';
import 'package:quizgram/screens/turkish/turkish_exam_detail.dart';
import 'package:quizgram/utils/images.dart';
import 'package:http/http.dart' as http;
import '../../utils/constant.dart';
import '../../utils/widget_assets.dart';
import '../discover_screen/discover_screen.dart';
import '../setting_screen/setting_screen.dart';

class NationalExamDays extends StatefulWidget {
  const NationalExamDays({Key? key}) : super(key: key);

  @override
  State<NationalExamDays> createState() => _NationalExamDaysState();
}

class _NationalExamDaysState extends State<NationalExamDays> {
  var box = Hive.box('user');
  late int status = 0;
  String _statusText = "Yuklanmoqda...";
  List<Map<String, dynamic>> olympicsData = [];
  TabController? _controller;
  int? _selectedItem = 0;

  Future<void> fetchData() async {
    var token = box.get('token');
    print(token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    var request = http.Request('POST', Uri.parse(WebApiConstans.getNationalExamDays));

    request.headers.addAll(headers);

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        final data = json.decode(res);
        if (data['status'] == "failed") {
          setState(() {
            _statusText = "Imtixonlar mavjud emas";
          });
        }
        else if (data['status'] == "success") {
          final data = json.decode(res);
          setState(() {
            status = 1;
            olympicsData = List<Map<String, dynamic>>.from(data['olympics']);
          });
        }
      } else {
        setState(() {
          _statusText = "Imtixonlar mavjud emas";
        });
      }
    } else {
      setState(() {
        _statusText = "Internetga ulanmagansiz";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsHelpers.primaryColor,
        elevation: 0,
        title: widgetText(
          'Milliy sertifikat 📃',
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: ScreenUtil().setSp(15),
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
              Column(
                children: [
                  Container(
                    // margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
                  child: TabBar(
                      controller: _controller,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: CircleTabIndicator(
                          color: Colors.white, radius: 4),
                      labelStyle: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w700),
                      unselectedLabelStyle: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w400),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white70,
                      labelPadding: EdgeInsets.zero,
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(15),
                          right: ScreenUtil().setWidth(15)),
                      tabs: const [
                        Tab(
                          text: 'Tayyorgarlik 📚',
                        ),
                        Tab(
                          text: 'Imtihonlar 🖋',
                        ),
                      ],
                      onTap: (l) {

                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(10),
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
                              Container(
                                margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(20),
                                ),
                                child: widgetText('Imtihonlar jadvali',
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(24),
                                    color: ColorsHelpers.primaryColor),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: status == 1 ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: olympicsData.length,
                                    itemBuilder: (context, index) {
                                      final item = olympicsData[index];
                                      return Container(
                                        margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(10), top: 0),
                                        child: listItemOlympic(
                                            Image.network("${AssetUrls.logos}/${item['logo']}"),
                                            '${item['name']}',
                                            item['status'] == 0 ||  item['status'] == 2 ? 'Sana: ${item['date']}' : "Imtixon yakunlangan", () {
                                          // print(box.get('token'));
                                          Get.to(NationalExamDetail(name: item['name'], olympicId: item['id'], amount: item['amount'], quiz_count: item['quiz_count'], description: item['description'],));
                                        }, Colors.white, Colors.black,
                                            ColorsHelpers.grey2),
                                      );
                                    }) : Text(_statusText),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(10),
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
                                  top: ScreenUtil().setHeight(20),
                                ),
                                child: widgetText('Imtihonlar jadvali',
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(24),
                                    color: ColorsHelpers.primaryColor),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: status == 1 ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: olympicsData.length,
                                    itemBuilder: (context, index) {
                                      final item = olympicsData[index];
                                      return Container(
                                        margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(10), top: 0),
                                        child: listItemOlympic(
                                            Image.network("${AssetUrls.logos}/${item['logo']}"),
                                            '${item['name']}',
                                            item['status'] == 0 ||  item['status'] == 2 ? 'Sana: ${item['date']}' : "Imtixon yakunlangan", () {
                                          // print(box.get('token'));
                                          Get.to(NationalExamDetail(name: item['name'], olympicId: item['id'], amount: item['amount'], quiz_count: item['quiz_count'], description: item['description'],));
                                        }, Colors.white, Colors.black,
                                            ColorsHelpers.grey2),
                                      );
                                    }) : Text(_statusText),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
