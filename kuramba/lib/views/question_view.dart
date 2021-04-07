import 'package:flutter/material.dart';
import '../widgets/cards/question_display_card.dart';

import '../widgets/question_catalogue/slider.dart';


class QuestionView extends StatelessWidget {
  static const routeName = '/question_view';

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
        appBar: AppBar(
          backgroundColor: arguments['categoryColor'],
          title: Text(arguments['questionPreviews'][arguments['index']].title),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              QuestionDisplayCard(
                answertype: CustomSlider(),
                question: 'question',
              ),
            ]
            )
        )
    );
  }
}
