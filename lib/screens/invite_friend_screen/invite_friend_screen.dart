import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quizgram/controllers/olympic_api_controller.dart';
import 'package:quizgram/utils/custom_alerts.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:quizgram/utils/images.dart';
import 'package:quizgram/utils/widget_assets.dart';

class InviteFriendScreen extends StatefulWidget {
  const InviteFriendScreen({Key? key, required this.olympicId}) : super(key: key);
  final int olympicId;
  @override
  State<InviteFriendScreen> createState() => _InviteFriendScreenState();
}

class _InviteFriendScreenState extends State<InviteFriendScreen> {
  final textFieldFocusNode = FocusNode();
  final _promocodeController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    OlympicApiController apiController = OlympicApiController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: widgetText('Sotib olish',
            color: Colors.white,
            fontSize: ScreenUtil().setSp(24),
            fontWeight: FontWeight.w500),
        leading: Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
          child: const BackButton(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(24)),
        color: ColorsHelpers.primaryColor,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
              color: ColorsHelpers.dullLavender),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(Images.inviteFriendRound),
                  widgetText(
                    'PROMOKOD',
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.w700,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          Images.leaderboardAvatar5,
                          width: ScreenUtil().setSp(64),
                          height: ScreenUtil().setSp(64),
                        ),
                        SvgPicture.asset(
                          Images.leaderboardAvatar2,
                          width: ScreenUtil().setSp(64),
                          height: ScreenUtil().setSp(64),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.translate(
                      offset: Offset(0, ScreenUtil().setHeight(-6)),
                      child: SvgPicture.asset(
                        Images.inviteFriendCloud,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(24)),
                      child: widgetText(
                        'Promokod bilan arzon narxda sotib oling',
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w500,
                        align: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(24),
                        left: ScreenUtil().setHeight(24),
                        right: ScreenUtil().setHeight(24),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color.fromRGBO(0, 98, 204, 0.2),
                            width: ScreenUtil().setSp(2),
                          ),
                          color: ColorsHelpers.grey5),
                      child: TextFormField(
                        controller: _promocodeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20.0)),
                          fillColor: ColorsHelpers.grey5,
                          filled: true,
                          contentPadding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(19),
                          ),
                          hintText: 'Promokod',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(32),
                        bottom: ScreenUtil().setHeight(24),
                        left: ScreenUtil().setHeight(24),
                        right: ScreenUtil().setHeight(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                var res = await apiController.buyExam(widget.olympicId, _promocodeController.text);
                                if(res == 1){
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  buyAlert(context);
                                }
                                else{
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  balansErrorAlert(context);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: ColorsHelpers.primaryColor),
                                padding: EdgeInsets.symmetric(
                                    vertical: ScreenUtil().setHeight(16)),
                                child: widgetText(
                                  _isLoading ? "Tekshirilmoqda..." : 'Sotib olish',
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w700,
                                  align: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
