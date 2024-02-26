import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:quizgram/utils/custom_alerts.dart';
import 'package:quizgram/screens/otp/otp_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/auth_api_controller.dart';
import '../../controllers/other_user_api.dart';
import '../../utils/constant.dart';
import '../../utils/images.dart';
import '../../utils/widget_assets.dart';

class PaymentOrder extends StatefulWidget {
  const PaymentOrder({Key? key}) : super(key: key);

  @override
  State<PaymentOrder> createState() => _PaymentOrderState();
}

class _PaymentOrderState extends State<PaymentOrder> {
  bool isClicked = false;
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;
  final textFieldFocusNode2 = FocusNode();
  bool _obscured2 = false;
  final _phoneController = TextEditingController();
  bool isValidPass = false;
  bool _isLoading = false;
  int amount = 0;

  final _passController = TextEditingController();
  final _pass2Controller = TextEditingController();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void _toggleObscured2() {
    setState(() {
      _obscured2 = !_obscured2;
      if (textFieldFocusNode2.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
      textFieldFocusNode2.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('user');
    OtherApiController apiController = OtherApiController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(239, 238, 252, 1),
        elevation: 0,
        title: widgetText('Hisobni to\'ldirish', color: Colors.black),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        color: const Color.fromRGBO(239, 238, 252, 1),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(50),
              ),
              Container(
                child: Image.asset(Images.appLogoShadow),
                // height: ScreenUtil().setHeight(46),
                width: ScreenUtil().setWidth(130),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isClicked
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              widgetText('To\'lov tizimini tanlang:',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.black),
                              Wrap(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        var phone = box.get('phone');
                                        launchUrl(Uri.parse("https://my.click.uz/services/pay?amount=${amount}&merchant_id=18137&merchant_user_id=${phone}&service_id=25798&transaction_param=${phone}&return_url=https://idealquiz.uz/payment-success&card_type=humo"));
                                        SystemNavigator.pop();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                ScreenUtil().setSp(20))),
                                        alignment: Alignment.center,
                                        width: ((MediaQuery.of(context).size.width /
                                            2) -
                                            ScreenUtil().setWidth(32)),
                                        margin: EdgeInsets.all(
                                            ScreenUtil().setWidth(8)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(16),
                                            bottom: ScreenUtil().setHeight(16),
                                          ),
                                          child: Column(
                                            children: [
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                  ScreenUtil().setWidth(120),
                                                  maxHeight:
                                                  ScreenUtil().setWidth(48),
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  // padding: EdgeInsets.all(
                                                  //     ScreenUtil().setWidth(9)),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .setSp(16))),
                                                  child: Image.asset(
                                                    "assets/icons/click-white.jpg",
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: ScreenUtil().setHeight(8),
                                                    bottom:
                                                    ScreenUtil().setHeight(2)),
                                                child: widgetText(
                                                  "Click Up",
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil().setSp(16),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                  // GestureDetector(
                                  //     onTap: () {
                                  //
                                  //     },
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //           color: Colors.white,
                                  //           borderRadius: BorderRadius.circular(
                                  //               ScreenUtil().setSp(20))),
                                  //       alignment: Alignment.center,
                                  //       width: ((MediaQuery.of(context).size.width /
                                  //           2) -
                                  //           ScreenUtil().setWidth(32)),
                                  //       margin: EdgeInsets.all(
                                  //           ScreenUtil().setWidth(8)),
                                  //       child: Padding(
                                  //         padding: EdgeInsets.only(
                                  //           top: ScreenUtil().setHeight(16),
                                  //           bottom: ScreenUtil().setHeight(16),
                                  //         ),
                                  //         child: Column(
                                  //           children: [
                                  //             ConstrainedBox(
                                  //               constraints: BoxConstraints(
                                  //                 maxWidth:
                                  //                 ScreenUtil().setWidth(120),
                                  //                 maxHeight:
                                  //                 ScreenUtil().setWidth(48),
                                  //               ),
                                  //               child: Container(
                                  //                 width: MediaQuery.of(context)
                                  //                     .size
                                  //                     .width,
                                  //                 height: MediaQuery.of(context)
                                  //                     .size
                                  //                     .height,
                                  //                 // padding: EdgeInsets.all(
                                  //                 //     ScreenUtil().setWidth(9)),
                                  //                 decoration: BoxDecoration(
                                  //                     color: Colors.white,
                                  //                     borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         ScreenUtil()
                                  //                             .setSp(16))),
                                  //                 child: Image.asset(
                                  //                   "assets/icons/payme.png",
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Padding(
                                  //               padding: EdgeInsets.only(
                                  //                   top: ScreenUtil().setHeight(8),
                                  //                   bottom:
                                  //                   ScreenUtil().setHeight(2)),
                                  //               child: widgetText(
                                  //                 "Payme",
                                  //                 color: Colors.black,
                                  //                 fontSize: ScreenUtil().setSp(16),
                                  //                 fontWeight: FontWeight.w500,
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     )),
                                  // GestureDetector(
                                  //     onTap: () {
                                  //
                                  //     },
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //           color: Colors.white,
                                  //           borderRadius: BorderRadius.circular(
                                  //               ScreenUtil().setSp(20))),
                                  //       alignment: Alignment.center,
                                  //       width: ((MediaQuery.of(context).size.width /
                                  //           2) -
                                  //           ScreenUtil().setWidth(32)),
                                  //       margin: EdgeInsets.all(
                                  //           ScreenUtil().setWidth(8)),
                                  //       child: Padding(
                                  //         padding: EdgeInsets.only(
                                  //           top: ScreenUtil().setHeight(16),
                                  //           bottom: ScreenUtil().setHeight(16),
                                  //         ),
                                  //         child: Column(
                                  //           children: [
                                  //             ConstrainedBox(
                                  //               constraints: BoxConstraints(
                                  //                 maxWidth:
                                  //                 ScreenUtil().setWidth(120),
                                  //                 maxHeight:
                                  //                 ScreenUtil().setWidth(48),
                                  //               ),
                                  //               child: Container(
                                  //                 width: MediaQuery.of(context)
                                  //                     .size
                                  //                     .width,
                                  //                 height: MediaQuery.of(context)
                                  //                     .size
                                  //                     .height,
                                  //                 // padding: EdgeInsets.all(
                                  //                 //     ScreenUtil().setWidth(9)),
                                  //                 decoration: BoxDecoration(
                                  //                     color: Colors.white,
                                  //                     borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         ScreenUtil()
                                  //                             .setSp(16))),
                                  //                 child: Image.asset(
                                  //                   "assets/icons/uzum.jpg",
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Padding(
                                  //               padding: EdgeInsets.only(
                                  //                   top: ScreenUtil().setHeight(8),
                                  //                   bottom:
                                  //                   ScreenUtil().setHeight(2)),
                                  //               child: widgetText(
                                  //                 "Uzum bank",
                                  //                 color: Colors.black,
                                  //                 fontSize: ScreenUtil().setSp(16),
                                  //                 fontWeight: FontWeight.w500,
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     )),
                                  // GestureDetector(
                                  //     onTap: () {
                                  //
                                  //     },
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //           color: Colors.white,
                                  //           borderRadius: BorderRadius.circular(
                                  //               ScreenUtil().setSp(20))),
                                  //       alignment: Alignment.center,
                                  //       width: ((MediaQuery.of(context).size.width /
                                  //           2) -
                                  //           ScreenUtil().setWidth(32)),
                                  //       margin: EdgeInsets.all(
                                  //           ScreenUtil().setWidth(8)),
                                  //       child: Padding(
                                  //         padding: EdgeInsets.only(
                                  //           top: ScreenUtil().setHeight(16),
                                  //           bottom: ScreenUtil().setHeight(16),
                                  //         ),
                                  //         child: Column(
                                  //           children: [
                                  //             ConstrainedBox(
                                  //               constraints: BoxConstraints(
                                  //                 maxWidth:
                                  //                 ScreenUtil().setWidth(120),
                                  //                 maxHeight:
                                  //                 ScreenUtil().setWidth(48),
                                  //               ),
                                  //               child: Container(
                                  //                 width: MediaQuery.of(context)
                                  //                     .size
                                  //                     .width,
                                  //                 height: MediaQuery.of(context)
                                  //                     .size
                                  //                     .height,
                                  //                 // padding: EdgeInsets.all(
                                  //                 //     ScreenUtil().setWidth(9)),
                                  //                 decoration: BoxDecoration(
                                  //                     color: Colors.white,
                                  //                     borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         ScreenUtil()
                                  //                             .setSp(16))),
                                  //                 child: Image.asset(
                                  //                   "assets/icons/paynet.jpg",
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Padding(
                                  //               padding: EdgeInsets.only(
                                  //                   top: ScreenUtil().setHeight(8),
                                  //                   bottom:
                                  //                   ScreenUtil().setHeight(2)),
                                  //               child: widgetText(
                                  //                 "Paynet",
                                  //                 color: Colors.black,
                                  //                 fontSize: ScreenUtil().setSp(16),
                                  //                 fontWeight: FontWeight.w500,
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     )),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widgetText('Summani kiriting:',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(8),
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _phoneController,
                                  onTap: () {},
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                        Icons.account_balance_wallet_outlined,
                                        color: ColorsHelpers.primaryColor),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(19),
                                    ),
                                    hintText: '0.00',
                                  ),
                                ),
                              ),
                            ],
                          ),
                    isClicked
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(30),
                                bottom: ScreenUtil().setHeight(24)),
                            child: widgetButton(
                                widgetText(
                                    _isLoading
                                        ? "Tekshirilmoqda..."
                                        : 'To\'ldirish',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(16)),
                                height: 56.0,
                                radius: 20.0,
                                width: MediaQuery.of(context).size.width,
                                () async {
                              setState(() {
                                _isLoading = true;
                              });
                              int? enteredNumber =
                                  int.tryParse(_phoneController.text);
                              if (enteredNumber != null && enteredNumber > 0) {
                                var checkUser = await apiController
                                    .newPaymentOrder(enteredNumber);
                                if (checkUser == 1) {
                                  setState(() {
                                    amount = enteredNumber;
                                    _isLoading = false;
                                    isClicked = true;
                                  });
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  apiErrorAlert(context);
                                }
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                pleasePositiveNumberAlert(context);
                              }
                            }),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
