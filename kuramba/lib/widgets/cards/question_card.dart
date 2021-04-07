import 'package:flutter/material.dart';

import 'package:sustainability_network/widgets/cards/custom_card.dart';

import 'package:sustainability_network/views/question_view.dart';

class QuestionCard extends StatelessWidget {

  final questionPreviews;
  final int index;
  final Color categoryColor;

  QuestionCard({
    this.questionPreviews,
    this.index,
    this.categoryColor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CustomCard(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(questionPreviews[index].title),
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(
            QuestionView.routeName,
            arguments: {
              'questionPreviews' : questionPreviews,
              'categoryColor' : categoryColor,
              'index' : index
            }
          );
        },
      ),
    );
  }
}
