import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'custom_card.dart';
import '../../views/contact_profile_view.dart';

class UserCard extends StatelessWidget {
  final String userID;

  UserCard(
    this.userID,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').doc(userID).get(),
      builder: (context, userSnapshot) {
        return CustomCard(
          onTap: () {
            Navigator.of(context).pushNamed(
              ContactProfileView.routeName,
              arguments: userSnapshot,
            );
          },
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: userSnapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    // : Hero(
                    //     tag: userSnapshot.data.id,
                    //     child: Container(
                    //       child: userSnapshot.data['image_url'] == null
                    //           ? Image.asset(
                    //               'assets/images/blank_profile_picture.png',
                    //               fit: BoxFit.cover,
                    //             )
                    //           : Image.network(
                    //               userSnapshot.data['image_url'],
                    //               fit: BoxFit.cover,
                    //             ),
                    //       height: double.infinity,
                    //       width: double.infinity,
                    //     ),
                    //   ),
                    : Container(
                        child: userSnapshot.data['image_url'] == null
                            ? Image.asset(
                                'assets/images/blank_profile_picture.png',
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                userSnapshot.data['image_url'],
                                fit: BoxFit.cover,
                              ),
                        height: double.infinity,
                        width: double.infinity,
                      ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.8),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: userSnapshot.connectionState == ConnectionState.waiting
                      ? null
                      : Center(
                          child: Text(
                            '${userSnapshot.data['username']}',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
