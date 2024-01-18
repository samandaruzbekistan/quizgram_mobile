import 'dart:convert';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:quizgram/screens/otp/otp_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:quizgram/controllers/auth_api_controller.dart';
import 'package:quizgram/screens/login_screen/login_screen.dart';
import 'package:quizgram/screens/sign_up_with_email_screen/sign_up_with_email_screen.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:quizgram/utils/widget_assets.dart';
import '../../models/region.dart';
import '../../utils/images.dart';
import '../alerts/custom_alerts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isValidPass = false;
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  final _stateController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

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

  String? selectedValue;
  String selectedRegionName = "";
  List<DropdownMenuItem<String>> dropdownItems = [
    DropdownMenuItem(
      value: 'pupil',
      child: Text('O\'quvchi'),
    ),
    DropdownMenuItem(
      value: 'teacher',
      child: Text('O\'qituvchi'),
    ),
    DropdownMenuItem(
      value: 'student',
      child: Text('Talaba'),
    ),
    DropdownMenuItem(
      value: 'abituriyent',
      child: Text('Abituriyent'),
    ),
    DropdownMenuItem(
      value: 'person',
      child: Text('Erkin izlanuvchi'),
    ),
  ];

  void initState() {
    super.initState();
    _phoneController.text = "+998";
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('user');
    AuthApiController api_controller = AuthApiController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: widgetText("Ro'yhatdan o'tish", color: Colors.black),
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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(100),
              ),
              Container(
                child: Image.asset(Images.appLogoShadow),
                // height: ScreenUtil().setHeight(46),
                width: ScreenUtil().setWidth(130),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(8),
                ),
                child: TextFormField(
                  controller: _nameController,
                  onTap: () {},
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline,
                        color: ColorsHelpers.primaryColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0)),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(19),
                    ),
                    hintText: 'Ism Familya',
                  ),
                ),
              ),
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
                    prefixIcon:
                        Icon(Icons.phone, color: ColorsHelpers.primaryColor),
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
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(8),
                ),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone,
                        color: ColorsHelpers.primaryColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0)),
                    fillColor: Colors.white,
                    filled: true
                  ),
                  hint: Text("Hozirgi holatingiz"),
                  validator: (value) =>
                  value == null ? "Select a role" : null,
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                      selectedRegionName = dropdownItems
                          .firstWhere((item) => item.value == newValue)
                          .child
                          .toString();
                    });
                  },
                  items: dropdownItems,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(8),
                ),
                child: TextFormField(
                  controller: _stateController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.home_repair_service_outlined,
                        color: ColorsHelpers.primaryColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0)),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(19),
                    ),
                    hintText: 'O\'qish yoki ish joyi',
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(8),
                    ),
                    child: TextFormField(
                      controller: _passController,
                      onTap: () {},
                      obscureText: _obscured,
                      focusNode: textFieldFocusNode,
                      onChanged: (text) {
                        setState(() {
                          if (text.length > 7) {
                            isValidPass = true;
                          } else {
                            isValidPass = false;
                          }
                        });
                      },
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
                        hintText: 'Parol',
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                        child: widgetText(
                          'Parol 8 ta belgidan ko\'p bo\'lsin',
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                          color: const Color.fromRGBO(133, 132, 148, 1),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                        child: Icon(
                          isValidPass ? Icons.check : Icons.highlight_off_sharp,
                          color: isValidPass
                              ? ColorsHelpers.primaryColor
                              : Colors.red,
                        ),
                      )
                    ],
                  )
                ],
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
                    var phoneNumber = _phoneController.text;
                    setState(() {
                      _isLoading = true;
                    });
                    final connectivityResult =
                    await (Connectivity().checkConnectivity());
                    if(_phoneController.text.length != 13) {
                      phoneNumberLengthAlert(context);
                    }
                    else if((_stateController.text.length < 1) || (_nameController.text.length < 1) || (_passController.text.length < 1)){
                      formErrorAlert(context);
                    }
                    else if (connectivityResult != ConnectivityResult.none){
                      var result = await api_controller.check_user(phoneNumber.substring(phoneNumber.length - 9));
                      if (result == 1) {
                        setState(() {
                          _isLoading = false;
                        });
                        checkUserAlert(context);
                      }
                      else if(result == -1){
                        box.put('temp_name', _nameController.text);
                        var phoneNumber = _phoneController.text;
                        var send_otp = await api_controller.sendOtp(phoneNumber.substring(phoneNumber.length - 9));
                        if(send_otp == 1){
                          box.put('temp_phone', phoneNumber.substring(phoneNumber.length - 9));
                          box.put('temp_state', _stateController.text);
                          box.put('temp_eduState', selectedValue as String);
                          box.put('temp_password', _passController.text);
                          Get.to(OtpScreen());
                        }
                        else{
                          apiErrorAlert(context);
                        }
                        // var register = await api_controller.register(name: _nameController.text, phone: _phoneController.text, state: _stateController.text, eduState: selectedValue as String, pass: _passController.text);

                      }
                      else{
                        apiErrorAlert(context);
                      }
                    }
                    else{
                      setState(() {
                        _isLoading = false;
                      });
                      internetErrorAlert(context);
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white,)
                      : Text(
                          'Ro\'yhatdan o\'tish',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16)),
                        ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(10),
                    bottom: ScreenUtil().setHeight(24)),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Sizda akkaunt bormi? ",
                          style: TextStyle(
                              color: const Color.fromRGBO(133, 132, 148, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(16))),
                      TextSpan(
                        text: 'Kirish',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                        style: TextStyle(
                            color: ColorsHelpers.primaryColor,
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

