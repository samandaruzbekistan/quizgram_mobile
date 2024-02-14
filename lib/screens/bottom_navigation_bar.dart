import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quizgram/screens/olympics_screen/olympic_detail.dart';
import 'package:quizgram/screens/discover_screen/discover_screen.dart';
import 'package:quizgram/screens/faq_detail_screen/faq_detail_screen.dart';
import 'package:quizgram/screens/faq_screen/faq_screen.dart';
import 'package:quizgram/screens/home_screen/home_screeen.dart';
import 'package:quizgram/screens/invite_friend_screen/invite_friend_screen.dart';
import 'package:quizgram/screens/leaderboard/leaderboard_screen.dart';
import 'package:quizgram/screens/live_quiz_screen/live_quiz_screen.dart';
import 'package:quizgram/screens/live_quiz_screen/quiz_complete_screen.dart';
import 'package:quizgram/screens/profile_screen/profile_screen.dart';
import 'package:quizgram/screens/quiz/quiz_choose_category_screen/quiz_choose_category_screen.dart';
import 'package:quizgram/screens/setting_screen/setting_screen.dart';

import '../utils/constant.dart';

BottomNavigationBar bottomBar(int currentIndex){
  return BottomNavigationBar(
    showUnselectedLabels: true,
    iconSize: 25,
    selectedItemColor: ColorsHelpers.primaryColor,
    selectedFontSize: 18,
    currentIndex: currentIndex,
    unselectedItemColor: Colors.grey,
    onTap: (index) {
      // Handle navigation based on the tapped index
      switch (index) {
        case 0:
          if (currentIndex != index){
            Get.to(const HomeScreen());
          }
          break;
        case 1:
          if (currentIndex != index){
            Get.to(const QuizChooseCategoryScreen());
          }
          break;
        case 2:
          if (currentIndex != index){
            Get.to(const LeaderboardScreen());
          }
          break;
        case 3:
          if (currentIndex != index){
            Get.to(const ProfileScreen());
          }
          break;

        default:
        // Do nothing
          break;
      }
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.school), label: "Bo'limlar"),
      BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Natijalar"),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profil"),
    ],
  );
}