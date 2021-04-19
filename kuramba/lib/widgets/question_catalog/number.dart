import 'package:flutter/material.dart';

class Number extends StatefulWidget {
  @override
  _NumberState createState() => _NumberState();
}

class _NumberState extends State<Number> {

  final number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(10.0),
      child: TextField(
        controller: number,
        autocorrect: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(hintText: 'Number',),
    ),
    );
  }
}
