import 'package:flutter/material.dart';

enum Answer {
  answer1,
  answer2,
  answer3,
}

class RadioButton extends StatefulWidget {
  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  Answer _site = Answer.answer1;

  void answer(Answer value) {
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
            value: Answer.answer1,
            groupValue: _site,
            onChanged: answer,
          ),
        ),
      ],
    );
  }
}
