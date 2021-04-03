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
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('questions').snapshots(),
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
                  return Container(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: CustomCard(
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                  color: document['category'] == 'living'
                                      ? Colors.lightBlue
                                      : document['category'] == 'consumption'
                                          ? Colors.pink
                                          : Colors.amber,
                                  // Das hier ist vermutlich nicht die schlauste Methode das zu machen, aber mir fällt nichts besseres ein
                                  width: 25.0,
                                ))),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(document['question']),
                                )),
                            onTap: () {},
                          )));
                }).toList(),
              );
            }));
  }
}
