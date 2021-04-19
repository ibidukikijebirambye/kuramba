import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {

  bool firstValue = false;
  bool secondValue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          //secondary: const Icon(Icons.add),
          title: const Text('Answer 1'),
          value: this.firstValue,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (bool value) {
            setState(() {
              this.firstValue = value;
            });
          },
        ),
      ],
    );
  }
}
