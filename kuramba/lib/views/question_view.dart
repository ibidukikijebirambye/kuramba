import 'package:flutter/material.dart';

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
    );
  }
}
