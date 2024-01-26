import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizgram/screens/login_screen/login_screen.dart';
import 'package:quizgram/screens/olympics_screen/olympics_screen.dart';
import 'package:quizgram/screens/profile_screen/profile_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

checkUserAlert(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Xatolik",
    desc: "Bu telefon raqam tizimda ro'yhatdan o'tgan",
    buttons: [
      DialogButton(
        color: Colors.deepPurple,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

checkNotUserAlert(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Xatolik",
    desc: "Bu telefon raqam tizimda ro'yhatdan o'tmagan",
    buttons: [
      DialogButton(
        color: Colors.deepPurple,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

buyAlert(context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Xabar",
    desc: "Olimpiadaga qatnashish uchun ruxsat berildi",
    buttons: [
      DialogButton(
        color: Colors.deepPurple,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Get.offAll(Olympics()),
        width: 120,
      )
    ],
  ).show();
}

balansErrorAlert(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Xatolik",
    desc: "Balans yetarli emas",
    buttons: [
      DialogButton(
        color: Colors.deepPurple,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Get.offAll(ProfileScreen()),
        width: 120,
      )
    ],
  ).show();
}

phoneNumberLengthAlert(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Xatolik",
    desc: "Telefon raqam noto'g'ri to'ldirilgan",
    buttons: [
      DialogButton(
        color: Colors.deepPurple,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

pleasePositiveNumberAlert(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Xatolik",
    desc: "Iltimos musbat son kiriting",
    buttons: [
      DialogButton(
        color: Colors.deepPurple,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

apiErrorAlert(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Xatolik",
    desc: "Api da nosozlik",
    buttons: [
      DialogButton(
        color: Colors.deepPurple,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

loginErrorAlert(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Xatolik",
    desc: "Login yoki parol xato!",
    buttons: [
      DialogButton(
        color: Colors.deepPurple,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}


formErrorAlert(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Xatolik",
    desc: "Malumotlar to'liq to'ldirilmagan",
    buttons: [
      DialogButton(
        color: Colors.deepPurple,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

newPasswordAlert(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Xatolik",
    desc: "Parollar bir xil emas",
    buttons: [
      DialogButton(
        color: Colors.deepPurple,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

updatedPasswordAlert(context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Xabar",
    desc: "Parolingiz yangilandi",
    buttons: [
      DialogButton(
        color: Colors.deepPurple,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Get.offAll(LoginScreen()),
        width: 120,
      )
    ],
  ).show();
}


internetErrorAlert(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Xatolik",
    desc: "Internetga ulanmagansiz. Iltimos ulanishni tekshiring",
    buttons: [
      DialogButton(
        color: Colors.deepPurple,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}
