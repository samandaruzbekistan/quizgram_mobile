import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:quizgram/controllers/auth_api_controller.dart';
import 'package:quizgram/screens/alerts/custom_alerts.dart';


import '../../utils/images.dart';
import 'components/otp_form.dart';

class OtpScreen extends StatefulWidget {
  static String routeName = "/otp";

  const OtpScreen({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  int _secondsRemaining = 60;
  var box = Hive.box('user');
  bool _isResendButtonVisible = false;
  AuthApiController apiController = AuthApiController();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isResendButtonVisible = true;
        });
      }
    });

    // Update the countdown value using a listener
    _controller.addListener(() {
      setState(() {
        _secondsRemaining = (_controller.duration!.inSeconds - _controller.value * _controller.duration!.inSeconds).round();
      });
    });

    _controller.forward();
  }

  Future<void> _resendCode() async {
    var phone = "${box.get('temp_phone')}";
    var res = await apiController.sendOtp("${phone.substring(phone.length - 9)}");
    if(res == 1){
      setState(() {
        _isResendButtonVisible = false;
        _secondsRemaining = 60;
      });
      _controller.reset();
      _controller.forward();
    }
    else{
      apiErrorAlert(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var phone = "${box.get('temp_phone')}";
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  const Color.fromRGBO(239, 238, 252, 1),
        title: const Text("OTP tasdiqlash"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color.fromRGBO(239, 238, 252, 1),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    child: Image.asset(Images.appLogoShadow),
                    // height: ScreenUtil().setHeight(46),
                    width: ScreenUtil().setWidth(130),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Kod yuborildi",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "Telefon raqam +998 ** *** ${phone.substring(phone.length - 4)}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Qayta yuborish uchun qolgan vaqt: "),
                      Text(
                        "00:$_secondsRemaining",
                        style: const TextStyle(color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  OtpForm(status: widget.type),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: _isResendButtonVisible,
                    child: TextButton(
                      onPressed: _resendCode,
                      child: Text('Kodni qayta yuborish', style: TextStyle(fontSize: ScreenUtil().setWidth(15)),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
