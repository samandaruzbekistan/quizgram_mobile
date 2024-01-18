import 'dart:convert';
import 'dart:math';

import 'package:hive/hive.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:http/http.dart' as http;

class AuthApiController{
  final random = Random();
  var box = Hive.box('user');

  Future<int> register({
    required String name,
    required String phone,
    required String state,
    required String eduState,
    required String pass}) async {

    return 1;

  }

  Future<int> check_user(String phone) async {
    var request = http.MultipartRequest('POST', Uri.parse(WebApiConstans.checkUser));
    request.fields.addAll({
      'phone': phone
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      Map valueMap = json.decode(res);
      if(valueMap['status'] == 'success'){
        return 1;
      }
      else if(valueMap['status'] == 'failed'){
        return -1;
      }
      return 0;
    }
    else {
      return 0;
    }
  }

  int checkOtp(String code) {
    var otp_code = box.get('otp_code');
    if(otp_code == code){
      return 1;
    }
    else{
      return 0;
    }
  }

  Future<int> sendOtp(String phone) async {
    final fourDigitNumber = random.nextInt(9000) + 1000;
    box.put('otp_code', "${fourDigitNumber}");
    var request = http.MultipartRequest('POST', Uri.parse('https://markaz.ideal-study.uz/api/sendSms'));
    request.fields.addAll({
      'phone': phone,
      'code': "${fourDigitNumber}"
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      Map valueMap = json.decode(res);
      if(valueMap['message'] == "Waiting for SMS provider"){
        return 1;
      }
      return 0;
    }
    else {
      return 0;
    }
  }
}