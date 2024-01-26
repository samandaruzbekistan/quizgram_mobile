import 'dart:convert';
import 'dart:math';

import 'package:hive/hive.dart';

import 'package:quizgram/utils/constant.dart';
import 'package:http/http.dart' as http;

class OtherApiController{
  final random = Random();
  var box = Hive.box('user');

  Future<int> newPaymentOrder(int amount) async {
    var user_id = box.get('id');
    var user_phone = box.get('phone');
    var token = box.get('token');
    var headers = {
      'Authorization': 'Bearer ${token}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(WebApiConstans.newPaymentOrder));
    request.fields.addAll({
      'user_id': '${user_id}',
      'user_phone': "${user_phone}",
      'amount': '${amount}'
    });
    request.headers.addAll(headers);
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