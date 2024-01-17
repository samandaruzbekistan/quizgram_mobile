import 'package:quizgram/utils/constant.dart';
import 'package:http/http.dart' as http;

class AuthApiController{


  void register({
    required String name,
    required String phone,
    required String state,
    required String eduState,
    required String pass}){


  }

  Future<int> check_user(String phone) async {
    var request = http.MultipartRequest('POST', Uri.parse(WebApiConstans.checkUser));
    request.fields.addAll({
      'phone': phone
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return 1;
    }
    else {
      return 0;
    }
  }
}