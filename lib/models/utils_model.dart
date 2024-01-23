// ignore: depend_on_referenced_packages
import 'dart:ffi';

import 'package:collection/collection.dart';

class SectionModel{
  String? name;
  String? topic;
  String? sectionphoto;
  List<QuestionModel>? quizzes;

  SectionModel(this.name, this.topic, this.sectionphoto, this.quizzes);

}

class QuestionModel {
  String? question;
  String? photo;
  dynamic? ball;
  Map<String, bool>? answer;

  QuestionModel(this.question,this.photo,this.ball, this.answer);
}

class ReviewQuizModel {
  int? number;
  String? name;
  String? photo;
  String? answer;
  bool isSkip = false;
  bool isVn = false;

  ReviewQuizModel(this.number, this.name, this.answer, this.isSkip, this.isVn);
}

class QuestionNumber {
  final double? x;
  final double? y;
  QuestionNumber({this.x, this.y});
}

List<QuestionNumber> get question {
  final data = <double>[2, 4, 5, 7, 8];
  return data
      .mapIndexed(
          ((index, element) => QuestionNumber(x: index.toDouble(), y: element)))
      .toList();
}
