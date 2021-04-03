import 'package:flutter/material.dart';

class StatisticsView extends StatelessWidget {
  static const routeName = '/statistics_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: Center(
        child: const Text('Statistics'),
      ),
    );
  }
}
