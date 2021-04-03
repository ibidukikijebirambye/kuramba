import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/cards/custom_card.dart';

class DataView extends StatelessWidget {
  static const routeName = '/data_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('questions').get(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> questionsSnapshot) {
          if (!questionsSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: EdgeInsets.all(20.0),
            children: questionsSnapshot.data.docs.map((document) {
              Color categoryColor;
              switch (document['category']) {
                case 'living':
                  categoryColor = Colors.blue;
                  break;
                case 'consumption':
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
                        child: Text(document['question']),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
