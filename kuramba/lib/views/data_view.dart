import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../widgets/cards/question_card.dart';
import '../widgets/cards/question_category_card.dart';

import '../providers/question_catalog.dart';

class DataView extends StatelessWidget {
  static const routeName = '/data_view';

  final List<Map<String, dynamic>> _categories = [
    {
      'category': 'Living',
      'color': Colors.blue,
    },
    {
      'category': 'Consumption',
      'color': Colors.pink,
    },
    {
      'category': 'Nutrition',
      'color': Colors.amber,
    },
    {
      'category': 'Leisure',
      'color': Colors.purple,
    },
    {
      'category': 'Mobility',
      'color': Colors.lightGreen,
    },
    {
      'category': 'Traveling',
      'color': Colors.red,
    },
  ];

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
              final previews = Provider.of<QuestionCatalog>(
                context,
                listen: false,
              ).previews;
              // List<ExpansionPanel> children = [];
              // _categories.forEach(
              //   (category) {
              //     children.add(
              //       ExpansionPanel(
              //         headerBuilder: (BuildContext context, bool isOpen) =>
              //             Text(category['category']),
              //         body: ListView.builder(
              //           padding: const EdgeInsets.symmetric(horizontal: 10),
              //           shrinkWrap: true,
              //           itemCount: previews.length,
              //           itemBuilder: (BuildContext context, int index) {
              //             return QuestionCard(
              //               preview: previews[index],
              //               color: _categories[index]['color'],
              //             );
              //           },
              //         ),
              //       ),
              //     );
              //   },
              // );
              // return ExpansionPanelList(
              //     children: children,
              //     );
              return ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: _categories.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 20),
                itemBuilder: (BuildContext context, int index) {
                  return QuestionCategoryCard(
                    color: _categories[index]['color'],
                    category: _categories[index]['category'],
                    previews: previews
                        .where(
                          (preview) =>
                              preview.category ==
                              _categories[index]['category'],
                        )
                        .toList(),
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
