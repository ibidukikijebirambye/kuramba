import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sustainability_network/widgets/cards/question_category_card.dart';

import '../providers/question_catalog.dart';

class DataView extends StatelessWidget {
  static const routeName = '/data_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: ChangeNotifierProvider<QuestionCatalog>(
        create: (context) => QuestionCatalog(),
        builder: (context, _) => FutureBuilder(
          future: Provider.of<QuestionCatalog>(
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
              final questionPreviews = Provider.of<QuestionCatalog>(
                context,
                listen: false,
              ).previews;
              return ListView.builder(
                padding: EdgeInsets.all(20.0),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return QuestionCategoryCard(
                    categoryColor: categories[index]['color'],
                    questionPreviews: questionPreviews,
                    index: index,
                    categories: categories,
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

List categories = [
  {
    'title': 'Living',
    'color': Colors.blue,
  },
  {
    'title': 'Consumption',
    'color': Colors.pink,
  },
  {
    'title': 'Nutrition',
    'color': Colors.amber,
  },
  {
    'title': 'Leisure',
    'color': Colors.purple,
  },
  {
    'title': 'Mobility',
    'color': Colors.lightGreen,
  },
];
