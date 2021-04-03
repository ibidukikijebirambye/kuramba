import 'package:flutter/material.dart';

class ChallengesView extends StatelessWidget {
  static const routeName = '/challenges_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenges'),
      ),
      body: Center(
        child: const Text('Challenges'),
      ),
    );
  }
}
