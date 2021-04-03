import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  static const routeName = '/info_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: Center(
        child: const Text('Info'),
      ),
    );
  }
}
