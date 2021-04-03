import 'package:flutter/material.dart';

class LabeledDivider extends StatelessWidget {
  final String label;

  LabeledDivider(this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(label),
        ),
        Expanded(
          child: Divider(),
        ),
      ],
    );
  }
}
