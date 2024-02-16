import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:quizgram/screens/profile_screen/paymentOrder.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:quizgram/utils/images.dart';
import 'package:quizgram/utils/widget_assets.dart';
import '../bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;

import '../olympics_screen/olympic_detail.dart';

class OlympicResultsList extends StatefulWidget {
  const OlympicResultsList({Key? key}) : super(key: key);

  @override
  State<OlympicResultsList> createState() => _OlympicResultsListState();
}

class _OlympicResultsListState extends State<OlympicResultsList> {
  bool _isLoading = true;
  bool _isEmpty = false;
  bool _api = false;
  var box = Hive.box('user');
  List<Map<String, dynamic>> olympicsData = [];

  Future<void> fetchData() async {
    var token = box.get('token');
    var id = box.get('id');
    var headers = {'Authorization': 'Bearer ${token}'};
    var request = http.MultipartRequest('POST', Uri.parse(WebApiConstans.getCompletedOlympics));
    request.fields.addAll({'user_id': "${id}"});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final data = json.decode(res);
      if (data['status'] == 'success') {
        setState(() {
          _isLoading = false;
          olympicsData = List<Map<String, dynamic>>.from(data['results']);
        });
      } else {
        setState(() {
          _isLoading = false;
          _isEmpty = true;
          olympicsData = List<Map<String, dynamic>>.from(data['results']);
        });
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
    super.initState();
    fetchData();
  }



  @override
  Widget build(BuildContext context) {
    var box = Hive.box('user');
    var id = box.get('id');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text("Olimpiadalar natijalari", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
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
                    height: MediaQuery.of(context).size.height,
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
                                height: MediaQuery.of(context).size.height / 2,
                                margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(24),
                                  right: ScreenUtil().setWidth(24),
                                ),
                                child: Column(
                                  children: [
                                    _isLoading
                                      ? CircularProgressIndicator(color: Colors.black,)
                                      : _api
                                        ? Text('API da nosozlik, qayta urining', style: TextStyle(color: Colors.red),)
                                        : _isEmpty
                                          ? Text('Natijalaringiz mavjud emas', style: TextStyle(color: Colors.red),)
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: olympicsData.length,
                                              itemBuilder: (context, index) {
                                                final item = olympicsData[index];
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: ScreenUtil().setHeight(10), top: 0),
                                                  child: listItemOlympic(
                                                      Image.network("${AssetUrls.logos}/${item['exam_day']['logo']}"),
                                                      '${item['exam_day']['name']}',
                                                      'Sana: ${item['exam_day']['date']}', () {
                                                    // print(box.get('token'));
                                                    Get.to(OlympicDetailScreen(name: item['exam_day']['name'], olympicId: item['exam_day']['id'], amount: item['exam_day']['amount'], quiz_count: item['exam_day']['quiz_count'], description: item['exam_day']['description'],));
                                                  }, Colors.white, Colors.black,
                                                      ColorsHelpers.grey2),
                                                );
                                              }),
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
