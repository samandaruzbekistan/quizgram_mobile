import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:quizgram/screens/alerts/custom_alerts.dart';
import 'package:quizgram/screens/otp/otp_screen.dart';

import '../../controllers/auth_api_controller.dart';
import '../../utils/constant.dart';
import '../../utils/images.dart';
import '../../utils/widget_assets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isClicked = false;
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;
  final textFieldFocusNode2 = FocusNode();
  bool _obscured2 = false;
  final _phoneController = TextEditingController();
  bool isValidPass = false;
  bool _isLoading = false;

  final _passController = TextEditingController();
  final _pass2Controller = TextEditingController();

  void initState() {
    super.initState();
    _phoneController.text = "+998";
  }

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
    AuthApiController apiController = AuthApiController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(239, 238, 252, 1),
        elevation: 0,
        title: widgetText(!isClicked ? 'Parolni tiklash' : 'Yangi parol',
            color: Colors.black),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        color: const Color.fromRGBO(239, 238, 252, 1),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(24), right: ScreenUtil().setWidth(24)),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().setHeight(50),),
              Container(
                child: Image.asset(Images.appLogoShadow),
                // height: ScreenUtil().setHeight(46),
                width: ScreenUtil().setWidth(130),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                child: widgetText(
                  !isClicked
                      ? 'Ilovada ro\'yhatdan o\'tgan telefon raqamingizni kiriring.'
                      : 'Yangi parol kiriting. Parolingiz murakkab tuzilgan bo\'lsin.',
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(16),
                  color: const Color.fromRGBO(133, 132, 148, 1),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !isClicked
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widgetText('Telefon raqamingiz',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
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
                                    prefixIcon: Icon(Icons.phone,
                                        color: ColorsHelpers.primaryColor),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(19),
                                    ),
                                    hintText: 'Telefon',
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    isClicked
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widgetText('Yangi parol',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(8),
                                ),
                                child: TextFormField(
                                  onTap: () {},
                                  controller: _passController,
                                  onChanged: (text) {
                                    setState(() {
                                      if (text.length > 7) {
                                        isValidPass = true;
                                      } else {
                                        isValidPass = false;
                                      }
                                    });
                                  },
                                  obscureText: _obscured,
                                  focusNode: textFieldFocusNode,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock_outline,
                                        color: ColorsHelpers.primaryColor),
                                    suffixIcon: GestureDetector(
                                      onTap: _toggleObscured,
                                      child: Icon(
                                        _obscured
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        size: 24,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(19),
                                    ),
                                    hintText: 'Parol',
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    isClicked
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(8)),
                                child: widgetText(
                                  'Kamida 8 ta belgi bo\'lsin.',
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(14),
                                  color: const Color.fromRGBO(133, 132, 148, 1),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(8)),
                                child: Icon(
                                  isValidPass
                                      ? Icons.check
                                      : Icons.highlight_off_sharp,
                                  color: isValidPass
                                      ? ColorsHelpers.primaryColor
                                      : Colors.red,
                                ),
                              )
                            ],
                          )
                        : Container(),
                    isClicked
                        ? Container(
                            margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widgetText('Yangi parolni takrorlang',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(8),
                                  ),
                                  child: TextFormField(
                                    controller: _pass2Controller,
                                    onTap: () {},
                                    obscureText: _obscured2,
                                    focusNode: textFieldFocusNode2,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock_outline,
                                          color: ColorsHelpers.primaryColor),
                                      suffixIcon: GestureDetector(
                                        onTap: _toggleObscured2,
                                        child: Icon(
                                          _obscured2
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          size: 24,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(19),
                                      ),
                                      hintText: 'Parol',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(30),
                          bottom: ScreenUtil().setHeight(24)),
                      child: widgetButton(
                          widgetText(_isLoading ? "Tekshirilmoqda..." : 'Parolni tiklash',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16)),
                          height: 56.0,
                          radius: 20.0,
                          width: MediaQuery.of(context).size.width, () async {
                            if(isClicked == true){
                              if(_passController.text != _pass2Controller.text){
                                newPasswordAlert(context);
                              }
                              else{
                                final connectivityResult = await (Connectivity().checkConnectivity());
                                if (connectivityResult != ConnectivityResult.none){
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  var phoneNumber = _phoneController.text;
                                  box.put('temp_new_pass', _passController.text);
                                  box.put('temp_phone', phoneNumber.substring(phoneNumber.length - 9));
                                  var resOtp = await apiController.sendOtp(phoneNumber.substring(phoneNumber.length - 9));
                                  if(resOtp == 1){
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Get.offAll(OtpScreen(type: "updatePassword"));
                                  }
                                  else{
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    apiErrorAlert(context);
                                  }
                                }
                                else{
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  internetErrorAlert(context);
                                }
                              }
                            }
                            else{
                              if(_phoneController.text.length == 13){
                                var phoneNumber = _phoneController.text;
                                setState(() {
                                  _isLoading = true;
                                });
                                var checkUser = await apiController.check_user(phoneNumber.substring(phoneNumber.length - 9));
                                if(checkUser == 1){
                                  setState(() {
                                    _isLoading = false;
                                    isClicked = true;
                                  });
                                }
                                else{
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  checkNotUserAlert(context);
                                }
                              }
                              else{
                                setState(() {
                                  _isLoading = false;
                                });
                                phoneNumberLengthAlert(context);
                              }
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
