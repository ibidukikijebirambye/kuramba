import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/current_user_provider.dart';

import 'custom_card.dart';

class ContactDataCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AsyncSnapshot userSnapshot =
        ModalRoute.of(context).settings.arguments;

    return CustomCard(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: userSnapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).primaryColor,
                    backgroundImage:
                        userSnapshot.connectionState == ConnectionState.waiting
                            ? null
                            : userSnapshot.data['image_url'] == null
                                ? NetworkImage(
                                    'assets/images/blank_profile_picture.png',
                                  )
                                : NetworkImage(
                                    userSnapshot.data['image_url'],
                                  ),
                  ),
                  SizedBox(width: 40.0),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            ' ' + userSnapshot.data['username'],
                            style: TextStyle(fontSize: 28.0),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        ElevatedButton.icon(
                          onPressed: () => Provider.of<CurrentUserProvider>(
                            context,
                            listen: false,
                          ).addToContacts(userSnapshot.data['email']),
                          label: Text('Connect'),
                          icon: Icon(Icons.person_add_alt_1_sharp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
