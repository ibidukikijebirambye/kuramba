import 'package:flutter/material.dart';

class CustomErrorDialog extends StatelessWidget {
  final String message;

  CustomErrorDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Close',
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
        ),
      ],
    );
  }
}
