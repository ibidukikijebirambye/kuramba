import 'package:flutter/material.dart';

import 'package:sustainability_network/widgets/cards/custom_card.dart';

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
      padding: const EdgeInsets.all(20.0),
      child: CustomCard(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(questionPreviews[index].title),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
