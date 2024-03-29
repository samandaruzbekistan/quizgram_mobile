import 'dart:convert';
import 'dart:math';

import 'package:hive/hive.dart';
import 'package:quizgram/firebase_api.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:http/http.dart' as http;

class AuthApiController{
  final random = Random();
  var box = Hive.box('user');

  Future<int> register() async {
    var name = box.get('temp_name');
    var phone = box.get('temp_phone');
    var password = box.get('temp_password');
    var state = box.get('temp_state');
    var eduState = box.get('temp_eduState');
    var gender = box.get('temp_gender');
    var token = await FirebaseApi().getFCMToken();
    var request = http.MultipartRequest('POST', Uri.parse(WebApiConstans.register));
    print(WebApiConstans.register);
    request.fields.addAll({
      'name': '${name}',
      'phone': '${phone}',
      'password': '${password}',
      'state': '${state} ',
      'eduState': '${eduState}',
      'gender' : "${gender}"
    });

    if (token != null) {
      request.fields['fcm_token'] = "${token}";
    } else {
      // If token is not available or notifications are not allowed, send a placeholder string.
      request.fields['fcm_token'] = "token";
    }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      Map valueMap = json.decode(res);
      box.put('name', name);
      box.put('phone', phone);
      box.put('password', eduState);
      box.put('state', state);
      box.put('eduState', eduState);
      box.put('gender', gender);
      box.put('balans', 0);
      box.put('token', valueMap['token']);
      box.put('id', valueMap['user_id']);

      return 1;
    }
    else {
      return 0;
    }
  }

  Future<int> login(String phone, String password) async {
    var request = http.MultipartRequest('POST', Uri.parse(WebApiConstans.loginUrl));
    request.fields.addAll({
      'phone': phone,
      'password': password
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      Map valueMap = json.decode(res);
      if(valueMap['status'] == "success"){
        box.put('temp_name', valueMap['user']['name']);
        box.put('temp_phone', valueMap['user']['phone']);
        box.put('temp_balans', valueMap['user']['balans']);
        box.put('temp_state', valueMap['user']['state']);
        box.put('temp_gender', valueMap['user']['gender']);
        box.put('temp_eduState', valueMap['user']['eduState']);
        box.put('token', valueMap['token']);
        box.put('id', valueMap['user']['id']);
        return 1;
      }
      else{
        return 0;
      }
    }
    else {
      return 0;
    }

  }

  Future<int> check_user(String phone) async {
    var request = http.MultipartRequest('POST', Uri.parse(WebApiConstans.checkUser));
    request.fields.addAll({
      'phone': phone
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      print(res);
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


  Future<int> updatePassword() async {
    var password = box.get('temp_new_pass');
    var phone = box.get('temp_phone');
    var request = http.MultipartRequest('POST', Uri.parse(WebApiConstans.updatePassword));
    request.fields.addAll({
      'phone': phone,
      'password': password
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return 1;
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




  Future<int> updateFcmToken() async {
    var fcm_token = await FirebaseApi().getFCMToken();
    var phone = box.get('temp_phone');
    var token = box.get('token');
    var headers = {
      'Authorization': 'Bearer ${token}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(WebApiConstans.updateFcm));
    request.fields.addAll({
      'fcm_token': '${fcm_token}',
      'phone': phone
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var name = box.get('temp_name');
      var phone = box.get('temp_phone');
      var state = box.get('temp_state');
      var eduState = box.get('temp_eduState');
      var balans = box.get('temp_balans');
      var gender = box.get('temp_gender');
      box.put('name', name);
      box.put('phone', phone);
      box.put('gender', gender);
      box.put('password', eduState);
      box.put('state', state);
      box.put('eduState', eduState);
      box.put('balans', balans);
      return 1;
    }
    else {
      return 0;
    }
  }




  Future<int> sendOtp(String phone) async {
    final fourDigitNumber = random.nextInt(9000) + 1000;
    box.put('otp_code', "${fourDigitNumber}");
    var request = http.MultipartRequest('POST', Uri.parse(WebApiConstans.sendOtp));
    request.fields.addAll({
      'phone': phone,
      'code': "${fourDigitNumber}"
    });

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      Map valueMap = json.decode(res);
      if(valueMap['status'] == "waiting"){
        return 1;
      }
      return 0;
    }
    else {
      return 0;
    }
  }
}