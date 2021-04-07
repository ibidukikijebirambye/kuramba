import 'package:flutter/material.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:sustainability_network/widgets/cards/question_card.dart';

class QuestionCategoryCard extends StatelessWidget {

  final questionPreviews;
  final int index;
  final Color categoryColor;
  final categories;

  QuestionCategoryCard({
    this.questionPreviews,
    this.index,
    this.categoryColor,
    this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      padding: EdgeInsets.only(bottom: 30.0),
      decoration: BoxDecoration(
        color: categories[index]['color'],
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ExpansionCard(
        initiallyExpanded: false,
        borderRadius: 20,
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                categories[index]['title'],
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).textTheme.bodyText2.color,
                ),
              ),
            ],
          ),
        ),
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 7),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: questionPreviews.length,
                itemBuilder: (BuildContext context, int index) {
                  // access element from list using index
                  // you can create and return a widget of your choice
                  return QuestionCard(
                    questionPreviews: questionPreviews,
                    index: index,
                    categoryColor: categoryColor,
                  );
                }
            )
           )
        ],
      ),
    );
  }
}