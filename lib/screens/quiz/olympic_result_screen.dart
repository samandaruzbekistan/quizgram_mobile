import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizgram/screens/home_screen/home_screeen.dart';

import '../../utils/constant.dart';
import '../../utils/widget_assets.dart';

class OlympicResult extends StatefulWidget {
  const OlympicResult(
      {Key? key, required this.olympicsData, required this.selectedAnswers})
      : super(key: key);

  final Map<int, Map<String, dynamic>> selectedAnswers;
  final List olympicsData;

  @override
  State<OlympicResult> createState() => _OlympicResultState();
}

class _OlympicResultState extends State<OlympicResult> {
  Color isSelected = ColorsHelpers.dullLavender;
  Color isUnselected = Colors.white;
  Color trueSelect = Colors.green;
  Color falseSelect = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widgetText("Natijangiz saqlandi",
            fontSize: ScreenUtil().setSp(20),
            fontWeight: FontWeight.w500,
            color: Colors.white),
        backgroundColor: ColorsHelpers.primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: ColorsHelpers.primaryColor,
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    // height: MediaQuery.of(context).size.height / 1.21,
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(24),
                        bottom: ScreenUtil().setHeight(0),
                        left: ScreenUtil().setWidth(8),
                        right: ScreenUtil().setWidth(8)),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(15),
                              left: ScreenUtil().setWidth(16),),
                            child: Row(
                              children: [
                                widgetText(
                                    'Umumiy ball: 25.7',
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(5),
                              left: ScreenUtil().setWidth(16),),
                            child: Row(
                              children: [
                                Icon(Icons.check, color: Colors.green,),
                                widgetText(
                                    " To'g'ri javob: 40 ta",
                                    color: ColorsHelpers.grey2,
                                    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(5),
                              left: ScreenUtil().setWidth(16),),
                            child: Row(
                              children: [
                                Icon(Icons.cancel_outlined, color: Colors.red,),
                                widgetText(
                                    " Noto'g'ri javob: 40 ta",
                                    color: ColorsHelpers.grey2,
                                    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          ),
                          Center(
                            child: widgetButton(
                              widgetText(
                                  'Bosh sahifa',
                                  fontWeight:
                                  FontWeight.w500,
                                  fontSize:
                                  ScreenUtil()
                                      .setSp(16),
                                  color:
                                  Colors.white),
                                  () {
                                // Get.to(LiveQuizScreen());
                                Get.to(HomeScreen());
                              },
                              height: 50.0,
                              width: 150.0,
                              radius: 20.0,
                              margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(5),)
                        ]
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    // height: MediaQuery.of(context).size.height / 1.21,
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(24),
                        bottom: ScreenUtil().setHeight(0),
                        left: ScreenUtil().setWidth(8),
                        right: ScreenUtil().setWidth(8)),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        color: Colors.white),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: widget.olympicsData.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(16),
                                  left: ScreenUtil().setWidth(16),),
                                child: widgetText(
                                    '${widget
                                        .olympicsData[index]['section_name']}',
                                    color: ColorsHelpers.primaryColor,
                                    fontSize: ScreenUtil().setSp(20),
                                    fontWeight: FontWeight.w500),
                              ),
                              widget.olympicsData[index]['section_topic'] != ""
                                  ? Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(16),
                                    bottom: ScreenUtil().setHeight(8)),
                                child: widgetText(
                                    '${widget
                                        .olympicsData[index]['section_topic']}',
                                    color: ColorsHelpers.grey2,
                                    fontSize: ScreenUtil().setSp(15),
                                    fontWeight: FontWeight.w500),
                              )
                                  : Container(),
                              widget.olympicsData[index]['section_photo'] !=
                                  "no_photo"
                                  ? Padding(child: Image.network(
                                  "${AssetUrls.quizPhotos}/${widget
                                      .olympicsData[index]['section_photo']}"),
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(16)),)
                                  : Container(),
                              SizedBox(height: ScreenUtil().setHeight(10),),
                              ListView.builder(
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                  widget.olympicsData[index]['quizzes'].length,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemBuilder: (context, indexQuizzes) {
                                    return Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(8),
                                            left: ScreenUtil().setWidth(16),
                                            right: ScreenUtil().setWidth(16),
                                            bottom:
                                            ScreenUtil().setHeight(24),
                                          ),
                                          child: widget.olympicsData[index]['quizzes'][indexQuizzes]['math'] == "" ? widgetText(
                                            "${index}) ${widget.olympicsData[index]['quizzes'][indexQuizzes]['quiz']}",
                                            fontWeight: FontWeight.w500,
                                            align: TextAlign.center,
                                            fontSize: ScreenUtil().setSp(18),
                                          ) : widgetTextLatex(
                                            widget.olympicsData[index]['quizzes'][indexQuizzes]['quiz'],  widget.olympicsData[index]['quizzes'][indexQuizzes]['math'],
                                            fontWeight:FontWeight.w500,
                                            fontSize: ScreenUtil().setSp(16),
                                            align: TextAlign.left,
                                            color: Colors.black,
                                          ),
                                        ),
                                        ListView.builder(
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: widget
                                                .olympicsData[index]
                                            ['quizzes']
                                            [indexQuizzes]['answers']
                                                .length,
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemBuilder:
                                                (context, indexAnswers) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                  bottom: ScreenUtil()
                                                      .setHeight(16),
                                                  left: ScreenUtil()
                                                      .setWidth(16),
                                                  right: ScreenUtil()
                                                      .setWidth(16),
                                                ),
                                                child: widgetButton(
                                                  widgetText(
                                                    widget.olympicsData[index][
                                                    'quizzes']
                                                    [indexQuizzes]
                                                    ['answers'][
                                                    indexAnswers]['answer'],
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: ScreenUtil()
                                                        .setSp(16),
                                                    align: TextAlign.left,
                                                    color: widget
                                                        .selectedAnswers[widget
                                                        .olympicsData[index]['quizzes'][indexQuizzes]['id']] ==
                                                        widget
                                                            .olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers] ||
                                                        widget
                                                            .olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['correct'] ==
                                                            1
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                      () {

                                                  },
                                                  height: 56.0,
                                                  radius: 20.0,
                                                  paddingBtn: EdgeInsets.only(
                                                    left: ScreenUtil()
                                                        .setWidth(24),
                                                  ),
                                                  colorBorder:
                                                  ColorsHelpers.grey5,
                                                  color: widget
                                                      .selectedAnswers[widget
                                                      .olympicsData[index]['quizzes'][indexQuizzes]['id']] ==
                                                      widget
                                                          .olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]
                                                      ? widget
                                                      .olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['correct'] ==
                                                      1
                                                      ? trueSelect
                                                      : falseSelect
                                                      : widget
                                                      .olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['correct'] ==
                                                      1 ? trueSelect : Colors
                                                      .white,
                                                  widthBorder: 1.0,
                                                  align: Alignment.centerLeft,
                                                  width:
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width,
                                                ),
                                              );
                                            })
                                      ],
                                    );
                                  }),
                            ]);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
