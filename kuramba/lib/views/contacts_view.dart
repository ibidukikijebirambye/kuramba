import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/current_user.dart';

import '../widgets/cards/user_card.dart';

class ContactsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CurrentUser>(
        builder: (context, userProvider, _) {
          return userProvider.user.contacts.length == 0
              ? Center(
                  child: Text(
                    'You don\'t have any contacts yet.\nStart adding some!',
                    textAlign: TextAlign.center,
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return UserCard(
                      userProvider.user.contacts[index],
                    );
                  },
                  itemCount: userProvider.user.contacts.length,
                );
        },
      ),
    );
  }
}
