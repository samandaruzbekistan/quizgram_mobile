import 'package:flutter/material.dart';

class WebApiConstans{
  static String baseUrl = 'https://mobile.idealquiz.uz/api/';
  static String loginUrl = baseUrl+'login';
  static String register = baseUrl+'register';
  static String checkUser = baseUrl+'check-user';
  static String sendOtp = baseUrl+'sendOtp';
  static String updateFcm = baseUrl+'updateFcm';
  static String updatePassword = baseUrl+'updatePassword';
  static String getBalansAndNews = baseUrl+'getBalansAndNews';
  static String getOlympics = baseUrl+'getOlympics';
  static String checkBuyOlympic = baseUrl+'checkBuyOlympic';
  static String getCompletedOlympics = baseUrl+'getCompletedOlympics';
  static String buyOlympicExam = baseUrl+'buyOlympicExam';
  static String playOlympicExam = baseUrl+'playOlympicExam';
  static String saveOlympicExamResult = baseUrl+'saveOlympicExamResult';
  static String getExamResults = baseUrl+'getExamResults';
  static String newPaymentOrder = baseUrl+'newPaymentOrder';



  static String getTurkishExamDays = baseUrl+'getTurkishExamDays';
  static String checkBuyTurkish = baseUrl+'checkBuyTurkish';
  static String buyTurkishExam = baseUrl+'buyTurkishExam';
  static String playTurkishExam = baseUrl+'playTurkishExam';
  static String saveTurkishExamResult = baseUrl+'saveTurkishExamResult';
  static String getCompletedTurkish = baseUrl+'getCompletedTurkish';




  static String getNationalExamDays = baseUrl+'getNationalExamDays';
  static String checkBuyNational = baseUrl+'checkBuyNational';
  static String buyNationalExam = baseUrl+'buyNationalExam';
  static String playNationalExam = baseUrl+'playNationalExam';
  static String saveNationalExamResult = baseUrl+'saveNationalExamResult';
  static String getCompletedNational = baseUrl+'getCompletedNational';

  static String googlePlay = "https://play.google.com/store/apps/details?id=uz.goldapps.idealquiz";
}

class AssetUrls{
  static String baseUrl = 'https://mobile.idealquiz.uz/';
  static String quizPhotos = baseUrl+'img/quiz';
  static String logos = baseUrl+'img/logos';
  static String olympicAudios = baseUrl+'audio/olympic';
}

class ColorsHelpers {
  static Color primaryColor = const Color.fromRGBO(106, 90, 224, 1);
  static Color grey1 = const Color.fromRGBO(73, 70, 95, 1);
  static Color grey2 = const Color.fromRGBO(133, 132, 148, 1);
  static Color grey4 = const Color.fromRGBO(230, 230, 230, 1);
  static Color grey5 = const Color.fromRGBO(239, 238, 252, 1);
  static Color orange = const Color.fromRGBO(255, 179, 128, 1);
  static Color orangeSecond = const Color.fromRGBO(255, 155, 87, 1);
  static Color dullLavender = const Color.fromRGBO(144, 135, 229, 1);
  static Color secondLavender = const Color.fromRGBO(193, 188, 241, 1);
  static Color thirdLavender = const Color.fromRGBO(232, 229, 250, 1);
  static Color fourthLavender = const Color.fromRGBO(217, 212, 247, 1);
  static Color grey4Opacity0_7 = const Color.fromRGBO(230, 230, 230, 0.7);
  static Color neutralOpacity0_3 = const Color.fromRGBO(12, 9, 42, 0.3);
  static Color neutralOpacity0_5 = const Color.fromRGBO(12, 9, 42, 0.5);
  static Color neutralOpacity0_2 = const Color.fromRGBO(12, 9, 42, 0.2);
  static Color pink = const Color.fromRGBO(255, 143, 162, 1);
  static Color whiteOpacity0_2 = const Color.fromRGBO(255, 255, 255, 0.2);
  static Color pinkAccent = const Color.fromRGBO(255, 214, 221, 1);
  static Color peach = const Color.fromRGBO(255, 224, 230, 1);
  static Color redBlood = const Color.fromRGBO(102, 0, 18, 1);
  static Color pink2 = const Color.fromRGBO(255, 179, 192, 1);
  static Color tosca = const Color.fromRGBO(136, 226, 206, 1);
  static Color red = const Color.fromRGBO(255, 102, 129, 1);
  static Color red2 = const Color.fromRGBO(255, 102, 102, 1);
  static Color green = const Color.fromRGBO(83, 223, 131, 1);
}
