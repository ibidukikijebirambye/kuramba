import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';

import 'question_card.dart';

class QuestionCategoryCard extends StatelessWidget {
  final previews;
  final Color color;
  final String category;

  QuestionCategoryCard({
    this.previews,
    this.color,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ExpansionCard(
        initiallyExpanded: false,
        borderRadius: 30,
        title: Text(
          category,
          style: TextStyle(
            fontSize: 25,
            color: Theme.of(context).textTheme.bodyText2.color,
          ),
        ),
        children: <Widget>[
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            shrinkWrap: true,
            itemCount: previews.length,
            itemBuilder: (BuildContext context, int index) {
              return QuestionCard(
                preview: previews[index],
                color: color,
              );
            },
          ),
        ],
      ),
    );
  }
}
