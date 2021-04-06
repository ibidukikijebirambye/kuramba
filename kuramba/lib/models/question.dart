import 'package:flutter/foundation.dart';

enum QuestionCategory {
  living,
  consumption,
  nutrition,
  leisure,
  mobility,
  traveling,
  miscellaneous,
}

class QuestionPreview {
  final String id;
  final String title;
  final QuestionCategory category;

  QuestionPreview(
    this.id,
    this.title,
    this.category,
  );
}

class Answer {
  final String answer;
  final int points;

  Answer({
    @required this.answer,
    @required this.points,
  });
}

class Question {
  final String id;
  final String title;
  final QuestionCategory category;
  final String question;

  Question({
    @required this.id,
    @required this.title,
    @required this.category,
    @required this.question,
  });
}

class NumberQuestion extends Question {
  int minValue;
  int maxValue;

  NumberQuestion({
    @required id,
    @required title,
    @required category,
    @required question,
    this.minValue,
    this.maxValue,
  }) : super(
          id: id,
          title: title,
          category: category,
          question: question,
        );
}

class CheckBoxQuestion extends Question {
  final List<Answer> answers;
  int requiredAnswers;

  CheckBoxQuestion({
    @required id,
    @required title,
    @required category,
    @required question,
    @required this.answers,
    this.requiredAnswers,
  }) : super(
          id: id,
          title: title,
          category: category,
          question: question,
        );
}

class ComboBoxQuestion extends Question {
  final List<Answer> answers;

  ComboBoxQuestion({
    @required id,
    @required title,
    @required category,
    @required question,
    @required this.answers,
  }) : super(
          id: id,
          title: title,
          category: category,
          question: question,
        );
}

class RadioButtonQuestion extends Question {
  final List<Answer> answers;

  RadioButtonQuestion({
    @required id,
    @required title,
    @required category,
    @required question,
    @required this.answers,
  }) : super(
          id: id,
          title: title,
          category: category,
          question: question,
        );
}

class SliderQuestion extends Question {
  final int minValue;
  final int maxValue;
  int divisions;

  SliderQuestion({
    @required id,
    @required title,
    @required category,
    @required question,
    @required this.minValue,
    @required this.maxValue,
    this.divisions,
  }) : super(
          id: id,
          title: title,
          category: category,
          question: question,
        );
}
