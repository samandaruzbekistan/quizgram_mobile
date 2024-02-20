import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizgram/screens/home_screen/home_screeen.dart';

import '../../utils/constant.dart';
import '../../utils/widget_assets.dart';

class OldTurkishResult extends StatefulWidget {
  const OldTurkishResult(
      {Key? key, required this.olympicsData,required this.start,required this.end,required this.total,required this.inCorrect, required this.correct, required this.selectedAnswers})
      : super(key: key);

  final Map<int, Map<String, dynamic>> selectedAnswers;
  final List olympicsData;
  final int correct;
  final String start;
  final String end;
  final int inCorrect;
  final String total;

  @override
  State<OldTurkishResult> createState() => _OldTurkishResultState();
}

class _OldTurkishResultState extends State<OldTurkishResult> {
  Color isSelected = ColorsHelpers.dullLavender;
  Color isUnselected = Colors.white;
  Color trueSelect = Colors.green;
  Color falseSelect = Colors.red;

  Map<String, TextEditingController> _writingControllers = {};

  void prepare(){
    widget.olympicsData.forEach((section) {
      var quizzes = section['quizzes'];
      quizzes.forEach((quiz){
        if((quiz['type'] == 'writing') || (quiz['type'] == 'puzzle')){
          if (widget.selectedAnswers[quiz['id']]?['answer_data'] != null){
            setState(() {
              _writingControllers["${quiz['id']}"] = new TextEditingController();
              _writingControllers["${quiz['id']}"]?.text = "${widget.selectedAnswers[quiz['id']]?['answer_data']}";
            });
          }
          else{
            setState(() {
              _writingControllers["${quiz['id']}"] = new TextEditingController();
              _writingControllers["${quiz['id']}"]?.text = "Javob berilmagan";
            });
          }
        }
        print(widget.selectedAnswers[quiz['id']]?['answer_data']['answer']);
        // print(quiz['id']);
      });
    });

  }

  @override
  void initState() {
    prepare();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widgetText("Sizning natijangiz:",
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
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
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
                                    'Umumiy ball: ${widget.total}',
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
                                    " To'g'ri javob: ${widget.correct} ta",
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
                                    " Noto'g'ri javob: ${widget.inCorrect} ta",
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
                                Icon(Icons.timer_outlined, color: Colors.orange,),
                                widgetText(
                                    " Boshlandi: ${widget.start}",
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
                                Icon(Icons.timer_off_outlined, color: Colors.orange,),
                                widgetText(
                                    " Yakunlandi: ${widget.end}",
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
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(5)),
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(5),)
                        ]
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
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
                                    '${widget.olympicsData[index]['section_name']}',
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
                                            top: ScreenUtil().setHeight(18),
                                            left: ScreenUtil().setWidth(16),
                                            right: ScreenUtil().setWidth(16),
                                            bottom: ScreenUtil().setHeight(8),
                                          ),
                                          child: widget.olympicsData[index]['quizzes'][indexQuizzes]['math'] == null ? widgetText("${indexQuizzes+1}) ${widget.olympicsData[index]['quizzes'][indexQuizzes]['quiz']}",
                                            fontWeight: FontWeight.w500,
                                            align: TextAlign.center,
                                            fontSize: ScreenUtil().setSp(18),
                                          ) : widgetTextLatex(
                                            widget.olympicsData[index]['quizzes'][indexQuizzes]['quiz'],
                                            widget.olympicsData[index]['quizzes'][indexQuizzes]['math'],
                                            fontWeight: FontWeight.w500,
                                            fontSize: ScreenUtil().setSp(16),
                                            align: TextAlign.left,
                                            color: Colors.black,
                                          ),
                                        ),
                                        widget.olympicsData[index]['quizzes'][indexQuizzes]['photo'] != "no_photo"
                                            ? Padding(
                                          child: Image.network("${AssetUrls.quizPhotos}/${widget .olympicsData[index]['quizzes'][indexQuizzes]['photo']}"),
                                          padding: EdgeInsets.symmetric(horizontal:ScreenUtil().setWidth(16), vertical: ScreenUtil().setWidth(5)),
                                        )
                                            : Container(),
                                        widget.olympicsData[index]['quizzes'][indexQuizzes]['type'] == "quiz4" || widget.olympicsData[index]['quizzes'][indexQuizzes]['type'] == "quiz6"
                                            ? ListView.builder(
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: widget.olympicsData[index]['quizzes'][indexQuizzes]['answers'].length,
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemBuilder:(context, indexAnswers) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                  bottom: ScreenUtil().setHeight(16),
                                                  left: ScreenUtil().setWidth(16),
                                                  right: ScreenUtil().setWidth(16),
                                                ),
                                                child: widgetButtonQuiz(
                                                  widget.olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['math'] !=
                                                      null ?
                                                  widgetTextLatex(
                                                    widget.olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['answer'],
                                                    widget.olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['math'],
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: ScreenUtil().setSp(16),
                                                    align: TextAlign.left,
                                                    color: widget.selectedAnswers[widget.olympicsData[index]['quizzes'][indexQuizzes]['id']] != null
                                                        ? widget.selectedAnswers[widget.olympicsData[index]['quizzes'][indexQuizzes]['id']]!['answer_data']['answer'] == '${widget.olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['answer']}'
                                                        ? Colors.white
                                                        : widget.olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['correct'] == 1 ? Colors.white : Colors.black
                                                        : Colors.black,
                                                  ) : widgetText(
                                                    widget.olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['answer'],
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: ScreenUtil().setSp(16),
                                                    align: TextAlign.left,
                                                    color: widget.selectedAnswers[widget.olympicsData[index]['quizzes'][indexQuizzes]['id']] != null
                                                        ? widget.selectedAnswers[widget.olympicsData[index]['quizzes'][indexQuizzes]['id']]!['answer_data']['answer'] == '${widget.olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['answer']}'
                                                        ? Colors.white
                                                        : widget.olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['correct'] == 1 ? Colors.white : Colors.black
                                                        : Colors.black,
                                                  ),
                                                      () {

                                                  },
                                                  height: 56.0,
                                                  radius: 20.0,
                                                  paddingBtn: EdgeInsets.only(
                                                    left: ScreenUtil().setWidth(24),
                                                  ),
                                                  colorBorder:ColorsHelpers.grey5,
                                                  color: widget.selectedAnswers[widget.olympicsData[index]['quizzes'][indexQuizzes]['id']] != null
                                                      ? widget.selectedAnswers[widget.olympicsData[index]['quizzes'][indexQuizzes]['id']]!['answer_data']['answer'] == '${widget.olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['answer']}'
                                                      ? trueSelect
                                                      : widget.olympicsData[index]['quizzes'][indexQuizzes]['answers'][indexAnswers]['correct'] == 1 ? falseSelect : Colors.white
                                                      : Colors.white,
                                                  widthBorder: 1.0,
                                                  align: Alignment.centerLeft,
                                                  width: MediaQuery.of(context).size.width,
                                                ),
                                              );
                                            })
                                            : Container(),
                                        widget.olympicsData[index]['quizzes'][indexQuizzes]['type'] == "writing"
                                            ? Container(
                                          margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(16),
                                            right: ScreenUtil().setWidth(16),
                                          ),
                                          child: TextFormField(
                                            maxLines: 5,
                                            readOnly: true,
                                            controller : _writingControllers['${widget.olympicsData[index]['quizzes'][indexQuizzes]['id']}'],
                                            decoration:InputDecoration(
                                              focusedBorder:OutlineInputBorder(
                                                borderRadius:BorderRadius.circular(20.0),
                                                borderSide:BorderSide(width:2,color:ColorsHelpers.grey5),
                                              ),
                                              enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(20.0),
                                                borderSide:BorderSide(width:2,color:ColorsHelpers.grey5),
                                              ),
                                              border: OutlineInputBorder(borderRadius:BorderRadius.circular(20.0)),
                                              fillColor:Colors.white,
                                              filled: true,
                                              errorText: widget.selectedAnswers[widget.olympicsData[index]['quizzes'][indexQuizzes]['id']]?['is_check'] == 0
                                                  ? 'Tekshirish jarayonida...'
                                                  : widget.selectedAnswers[widget.olympicsData[index]['quizzes'][indexQuizzes]['id']]?['is_check'] == 1
                                                  ? "${widget.selectedAnswers[widget.olympicsData[index]['quizzes'][indexQuizzes]['id']]?['ball']} ball"
                                                  : null,
                                              hintText: "Matn...",
                                              contentPadding:EdgeInsets.only(left: ScreenUtil().setWidth(19),
                                              ),
                                            ),
                                          ),
                                        )
                                            : Container(),
                                        widget.olympicsData[index]['quizzes'][indexQuizzes]['type'] == "puzzle"
                                            ? Container(
                                          margin: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(8),
                                            left: ScreenUtil().setWidth(16),
                                            right: ScreenUtil().setWidth(16),
                                            bottom: ScreenUtil().setHeight(24),
                                          ),
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height * 0.06,
                                          // decoration: BoxDecoration(
                                          //   borderRadius: BorderRadius.circular(20),
                                          //   border: Border.all(
                                          //     color: const Color.fromRGBO(0, 98, 204, 0.2),
                                          //     width: ScreenUtil().setSp(2),
                                          //   ),
                                          //   color: ColorsHelpers.grey5,
                                          // ),
                                          child: TextFormField(
                                            readOnly: true,
                                            maxLines: 3,
                                            onTap: () {},
                                            controller : _writingControllers['${widget.olympicsData[index]['quizzes'][indexQuizzes]['id']}'],
                                            decoration:InputDecoration(
                                              focusedBorder:OutlineInputBorder(
                                                borderRadius:BorderRadius.circular(20.0),
                                                borderSide:BorderSide(width:2,color:ColorsHelpers.grey5),
                                              ),
                                              enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(20.0),
                                                borderSide:BorderSide(width:2,
                                                    color: widget.selectedAnswers[widget.olympicsData[index]['quizzes'][indexQuizzes]['id']]?['correct_text'] == widget.selectedAnswers[widget.olympicsData[index]['quizzes'][indexQuizzes]['id']]?['answer_data']
                                                        ? ColorsHelpers.green
                                                        : ColorsHelpers.red
                                                ),
                                              ),
                                              border: OutlineInputBorder(borderRadius:BorderRadius.circular(20.0)),
                                              fillColor:Colors.white,
                                              filled: true,
                                              contentPadding:EdgeInsets.only(left: ScreenUtil().setWidth(19),
                                              ),
                                            ),
                                          ),
                                        )
                                            : Container(),
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
