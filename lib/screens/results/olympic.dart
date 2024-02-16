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
class OlympicResultsList extends StatefulWidget {
  const OlympicResultsList({Key? key}) : super(key: key);

  @override
  State<OlympicResultsList> createState() => _OlympicResultsListState();
}

class _OlympicResultsListState extends State<OlympicResultsList>
    with TickerProviderStateMixin {




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
