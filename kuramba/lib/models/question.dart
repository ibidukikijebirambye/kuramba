import 'package:flutter/foundation.dart';

enum Category {
  Living,
  Consumption,
  Nutrition,
  Leisure,
  Mobility,
  Traveling,
}

enum AnswerType {
  Number,
  CheckBox,
  ComboBox,
  RadioButton,
  Slider,
  Date,
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
