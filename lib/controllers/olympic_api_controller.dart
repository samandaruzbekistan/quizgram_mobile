import 'dart:convert';
import 'dart:math';

import 'package:hive/hive.dart';
import 'package:quizgram/firebase_api.dart';
import 'package:quizgram/utils/constant.dart';
import 'package:http/http.dart' as http;

class OlympicApiController{
  final random = Random();
  var box = Hive.box('user');

  Future<int> buyExam(int examId, String promocode) async {
    var user_id = box.get('id');
    var balans = box.get('balans');
    var token = box.get('token');
    var headers = {
      'Authorization': 'Bearer ${token}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(WebApiConstans.buyOlympicExam));
    request.fields.addAll({
      'user_id': '${user_id}',
      'exam_day_id': "${examId}",
      'promocode': '${promocode}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      Map valueMap = json.decode(res);
      if(valueMap['status'] == 'success'){
        var new_balans = int.parse(balans) - valueMap['amount'];
        box.put('balans', "${new_balans}");
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