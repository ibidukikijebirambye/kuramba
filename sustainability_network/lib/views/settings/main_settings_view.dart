import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/cards/custom_card.dart';
import '../../widgets/dialogs/custom_about_dialog.dart';
import 'theme_settings_view.dart';
import '../info_view.dart';

class MainSettingsView extends StatelessWidget {
  static const routeName = '/main_settings_view';

  Widget buildListTile(
      BuildContext context, String title, IconData icon, Function onPressed) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: CustomCard(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: ListTile(
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Icon(icon),
            onTap: onPressed,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Title _ancestorTitle = context.findAncestorWidgetOfExactType<Title>();
    final _appName = _ancestorTitle?.title ??
        Platform.resolvedExecutable.split(Platform.pathSeparator).last;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          buildListTile(
            context,
            'Theme',
            Icons.color_lens_rounded,
            () => Navigator.of(context).pushNamed(ThemeSettingsView.routeName),
          ),
          buildListTile(
            context,
            "Info Point",
            Icons.info_rounded,
            () => Navigator.of(context).pushNamed(InfoView.routeName),
          ),
          buildListTile(
            context,
            'Logout',
            Icons.logout,
            () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
          ),
          buildListTile(
            context,
            'About $_appName',
            Icons.policy_rounded,
            () => showDialog(
              context: context,
              builder: (context) {
                return CustomAboutDialog();
              },
            ),
          ),
        ],
      ),
    );
  }
}
