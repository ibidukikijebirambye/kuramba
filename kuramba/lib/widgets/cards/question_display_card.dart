import 'package:flutter/material.dart';

import 'custom_card.dart';

class QuestionDisplayCard extends StatelessWidget {

  final String question;
  final Widget answertype;

  QuestionDisplayCard({
    @required this.question,
    @required this.answertype,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                question,
                style: TextStyle(
                    fontSize: 17
                ),
              ),
            ),
            answertype
          ],
        ),
      ),
    );
  }
}