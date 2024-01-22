import 'dart:convert';
import 'dart:math';

import 'package:hive/hive.dart';
import 'package:quizgram/firebase_api.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:http/http.dart' as http;

class OlympicApiController{
  final random = Random();
  var box = Hive.box('user');

  Future<int> buyExam(int examId) async {
    var request = http.MultipartRequest('POST', Uri.parse(WebApiConstans.checkUser));

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

}