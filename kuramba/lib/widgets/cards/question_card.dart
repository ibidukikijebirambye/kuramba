import 'package:flutter/material.dart';

import '../../views/question_view.dart';

import '../../models/question.dart';

import 'custom_card.dart';

class QuestionCard extends StatelessWidget {
  final QuestionPreview preview;
  final Color color;

  QuestionCard({
    this.preview,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(preview.title),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(
            QuestionView.routeName,
            arguments: {
              'id': preview.id,
              'title': preview.title,
              'color': color,
            },
          );
        },
      ),
    );
  }
}
