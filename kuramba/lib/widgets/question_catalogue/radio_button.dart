import 'package:flutter/material.dart';

enum Answers {answer1, answer2, answer3}

class RadioButton extends StatefulWidget {

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {

  Answers _site = Answers.answer1;

  void answer (Answers value) {
    setState(() {
      _site = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Answer 1'),
          leading: Radio(
            activeColor: Theme.of(context).primaryColor,
            value: Answers.answer1,
            groupValue: _site,
            onChanged: answer,
          ),
        ),
      ],
    );
  }
}
