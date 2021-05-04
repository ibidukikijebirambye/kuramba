import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/question.dart';

class QuestionCatalog with ChangeNotifier {
  List<QuestionPreview> _questionPreviews = [];

  Future<void> fetchQuestionPreviews() async {
    try {
      final previewDoc = await FirebaseFirestore.instance
          .collection('questions')
          .doc('previews')
          .get();
      if (previewDoc.exists) {
        _questionPreviews = [];
        final previewData = previewDoc.data();
        previewData.forEach(
          (key, value) {
            _questionPreviews.add(
              QuestionPreview(
                  id: key,
                  title: value['title'],
                  // getCategory(value['category']),
                  category: value['category']),
            );
          },
        );
      }
    } catch (error) {
      throw error;
    }
  }

  // QuestionCategory getCategory(String category) {
  //   switch (category) {
  //     case 'living':
  //       return QuestionCategory.living;
  //       break;
  //     case 'consumption':
  //       return QuestionCategory.consumption;
  //       break;
  //     case 'nutrition':
  //       return QuestionCategory.nutrition;
  //       break;
  //     case 'leisure':
  //       return QuestionCategory.leisure;
  //       break;
  //     case 'mobility':
  //       return QuestionCategory.mobility;
  //       break;
  //     case 'traveling':
  //       return QuestionCategory.traveling;
  //       break;
  //     default:
  //       return QuestionCategory.miscellaneous;
  //   }
  // }

  List<QuestionPreview> get previews {
    return [..._questionPreviews];
  }

  Future<Question> getQuestion(String id) async {
    try {
      final questionDoc = await FirebaseFirestore.instance
          .collection('questions')
          .doc(id)
          .get();
      if (questionDoc.exists) {
        final questionData = questionDoc.data();
        print(questionData['type']);
        switch (questionData['type']) {
          case 'number':
            return NumberQuestion(
              id: id,
              title: questionDoc['title'],
              // category: getCategory(questionDoc['category']),
              category: questionDoc['category'],
              question: questionDoc['question'],
            );
            break;
          case 'checkbox':
            return CheckBoxQuestion(
              id: id,
              title: questionDoc['title'],
              // category: getCategory(questionDoc['category']),
              category: questionDoc['category'],
              question: questionDoc['question'],
              answers: questionDoc['answers']
                  .map(
                    (answer) => Answer(
                      answer: answer['answer'],
                      points: answer['points'],
                    ),
                  )
                  .toList(),
            );
            break;
          case 'combobox':
            return ComboBoxQuestion(
              id: id,
              title: questionDoc['title'],
              // category: getCategory(questionDoc['category']),
              category: questionDoc['category'],
              question: questionDoc['question'],
              answers: questionDoc['answers']
                  .map(
                    (answer) => Answer(
                      answer: answer['answer'],
                      points: answer['points'],
                    ),
                  )
                  .toList(),
            );
            break;
          case 'radiobutton':
            return RadioButtonQuestion(
              id: id,
              title: questionDoc['title'],
              // category: getCategory(questionDoc['category']),
              category: questionDoc['category'],
              question: questionDoc['question'],
              answers: questionDoc['answers']
                  .map(
                    (answer) => Answer(
                      answer: answer['answer'],
                      points: answer['points'],
                    ),
                  )
                  .toList(),
            );
            break;
          case 'slider':
            return SliderQuestion(
              id: id,
              title: questionDoc['title'],
              // category: getCategory(questionDoc['category']),
              category: questionDoc['category'],
              question: questionDoc['question'] ?? '',
              minValue: questionDoc['minValue'] ?? 0,
              maxValue: questionDoc['maxValue'] ?? 1,
            );
            break;
          default:
            return Question(
              id: id,
              title: questionDoc['title'],
              // category: getCategory(questionDoc['category']),
              category: questionDoc['category'],
              question: questionDoc['question'],
            );
        }
      } else {
        throw Exception(['Question not found.']);
      }
    } catch (error) {
      print(error.message);
    }
  }
}
