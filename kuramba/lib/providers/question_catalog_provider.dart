import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/question.dart';

class QuestionCatalogProvider with ChangeNotifier {
  // List<Question> _questions;
  List<QuestionPreview> _questionPreviews = [];

  Future<void> fetchQuestionPreviews() async {
    try {
      final previewDoc = await FirebaseFirestore.instance
          .collection('questions')
          .doc('previews')
          .get();
      if (previewDoc.exists) {
        final previewData = previewDoc.data();
        previewData.forEach(
          (key, value) {
            QuestionCategory category;
            switch (value['category']) {
              case 'living':
                category = QuestionCategory.living;
                break;
              case 'consumption':
                category = QuestionCategory.consumption;
                break;
              case 'nutrition':
                category = QuestionCategory.nutrition;
                break;
              case 'leisure':
                category = QuestionCategory.leisure;
                break;
              case 'mobility':
                category = QuestionCategory.mobility;
                break;
              case 'traveling':
                category = QuestionCategory.traveling;
                break;
              default:
                category = QuestionCategory.miscellaneous;
            }
            _questionPreviews.add(
              QuestionPreview(
                key,
                value['title'],
                category,
              ),
            );
          },
        );
      }
    } catch (error) {
      throw error;
    }
  }

  List<QuestionPreview> get previews {
    return [..._questionPreviews];
  }
}
