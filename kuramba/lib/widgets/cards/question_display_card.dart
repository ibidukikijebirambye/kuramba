import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_card.dart';

import 'package:sustainability_network/providers/question_catalog.dart';

class QuestionDisplayCard extends StatelessWidget {
  final Widget answerType;
  final String id;

  QuestionDisplayCard({
    @required this.answerType,
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuestionCatalog>(
        create: (context) => QuestionCatalog(),
        builder: (context, _) => FutureBuilder(
          future: Provider.of<QuestionCatalog>(
            context,
            listen: false,
          ).getQuestion(id),
          builder: (
              context,
              snapshot,
              ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final question = Provider.of<QuestionCatalog>(
                context,
                listen: false,
              ).getQuestion(id);
              return CustomCard(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          id,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      answerType,
                    ],
                  ),
                ),
              );
            }
          },
        ),
      );
  }
}
