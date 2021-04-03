import 'package:flutter/material.dart';

class AchievementsView extends StatelessWidget {
  static const routeName = '/achievements_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements'),
      ),
      body: Center(
        child: const Text('Achievements'),
      ),
    );
  }
}
