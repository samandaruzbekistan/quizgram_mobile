import 'package:flutter/material.dart';
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
