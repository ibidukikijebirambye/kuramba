import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cards/custom_card.dart';

import '../models/question.dart';

import '../providers/question_catalog_provider.dart';

class DataView extends StatelessWidget {
  static const routeName = '/data_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: ChangeNotifierProvider<QuestionCatalogProvider>(
        create: (context) => QuestionCatalogProvider(),
        builder: (context, _) => FutureBuilder(
          future: Provider.of<QuestionCatalogProvider>(
            context,
            listen: false,
          ).fetchQuestionPreviews(),
          builder: (
            context,
            snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final questionPreviews = Provider.of<QuestionCatalogProvider>(
                context,
                listen: false,
              ).previews;
              return ListView.builder(
                padding: EdgeInsets.all(20.0),
                itemCount: questionPreviews.length,
                itemBuilder: (context, index) {
                  Color categoryColor;
                  // TODO Add colors for all categories
                  switch (questionPreviews[index].category) {
                    case QuestionCategory.living:
                      categoryColor = Colors.blue;
                      break;
                    case QuestionCategory.nutrition:
                      categoryColor = Colors.pink;
                      break;
                    default:
                      categoryColor = Colors.amber;
                  }
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: CustomCard(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: categoryColor,
                                width: 25.0,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(questionPreviews[index].title),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
