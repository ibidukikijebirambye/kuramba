import 'package:flutter/foundation.dart';

enum Category {
  living,
  consumption,
  nutrition,
  leisure,
  mobility,
  traveling,
}

enum AnswerType {
  number,
  checkBox,
  comboBox,
  radioButton,
  slider,
  date,
}

class Question {
  final String title;
  final Category category;
  final String question;
  final AnswerType answerType;

  Question({
    @required this.title,
    @required this.category,
    @required this.question,
    @required this.answerType,
  });
}
