import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quizgram/controllers/auth_api_controller.dart';
import 'package:quizgram/utils/custom_alerts.dart';

import 'package:quizgram/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:quizgram/screens/home_screen/home_screeen.dart';
import 'package:quizgram/utils/images.dart';
import 'package:quizgram/utils/widget_assets.dart';

import '../../utils/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  final _passController = TextEditingController();
  final _phoneController = TextEditingController();
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
  bool _isLoading = false;
  void initState() {
    super.initState();
    _phoneController.text = "+998";
  }

  @override
  Widget build(BuildContext context) {
    AuthApiController apiController = AuthApiController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: widgetText('Kirish', color: Colors.black),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(24), right: ScreenUtil().setHeight(24)),
        color: const Color.fromRGBO(239, 238, 252, 1),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().setHeight(120),),
              Container(
                child: Image.asset(Images.appLogoShadow),
                // height: ScreenUtil().setHeight(46),
                width: ScreenUtil().setWidth(130),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(32),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widgetText('Telefon raqam',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(8),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone,
                              color: ColorsHelpers.primaryColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20.0)),
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
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widgetText('Parol',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(8),
                      ),
                      child: TextFormField(
                        controller: _passController,
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
                              borderRadius: BorderRadius.circular(20.0)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(19),
                          ),
                          hintText: 'Parolingiz',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(24),
                ),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsHelpers.primaryColor,
                      minimumSize:
                      Size(MediaQuery.of(context).size.width, 56.0),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 0.0,
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                  onPressed: () async {
                    final connectivityResult = await (Connectivity().checkConnectivity());
                    if(_phoneController.text.length != 13) {
                      phoneNumberLengthAlert(context);
                    }
                    else if (connectivityResult != ConnectivityResult.none){
                      setState(() {
                        _isLoading = true;
                      });
                      var phoneNumber = _phoneController.text;
                      var loginRes = await apiController.login(phoneNumber.substring(phoneNumber.length - 9), _passController.text);
                      if(loginRes == 1){
                        var resUpdateFcm = await apiController.updateFcmToken();
                        if (resUpdateFcm == 1){
                          setState(() {
                            _isLoading = false;
                          });
                          Get.offAll(HomeScreen());
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
                        loginErrorAlert(context);
                      }
                      setState(() {
                        _isLoading = true;
                      });
                    }
                    else{
                      setState(() {
                        _isLoading = false;
                      });
                      internetErrorAlert(context);
                    }
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white,)
                      : Text(
                    'Kirish',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(16)),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(30),),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
                child: GestureDetector(
                  child: widgetText('Parolingizni unutdingizmi?',
                      color: ColorsHelpers.primaryColor,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w500),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ForgotPasswordScreen()));
                  },
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: "By continuing, you agree to the ",
                        style:
                            TextStyle(color: Color.fromRGBO(133, 132, 148, 1))),
                    TextSpan(
                      text: 'Terms of Services ',
                      style: TextStyle(color: Color.fromRGBO(73, 70, 95, 1)),
                    ),
                    TextSpan(
                        text: '& ',
                        style:
                            TextStyle(color: Color.fromRGBO(133, 132, 148, 1))),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: Color.fromRGBO(73, 70, 95, 1)),
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
