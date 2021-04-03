import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class CustomAboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Title _ancestorTitle = context.findAncestorWidgetOfExactType<Title>();
    final _appName = _ancestorTitle?.title ??
        Platform.resolvedExecutable.split(Platform.pathSeparator).last;
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (
        context,
        packageSnapshot,
      ) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _appName,
                  style: Theme.of(context).dialogTheme.titleTextStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  packageSnapshot.hasData
                      ? 'Version ${packageSnapshot.data.version}'
                      : 'Loading version...',
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  packageSnapshot.hasData
                      ? 'Build ${packageSnapshot.data.buildNumber}'
                      : 'Loading build number...',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: Text(
                        'Licenses',
                        style: Theme.of(context)
                            .dialogTheme
                            .contentTextStyle
                            .copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      onPressed: () {
                        showLicensePage(
                          applicationVersion: packageSnapshot.hasData
                              ? '\nVersion ${packageSnapshot.data.version}\n\nBuild ${packageSnapshot.data.buildNumber}'
                              : 'Loading version...',
                          context: context,
                        );
                      },
                    ),
                    TextButton(
                      child: Text(
                        'Close',
                        style: Theme.of(context)
                            .dialogTheme
                            .contentTextStyle
                            .copyWith(
                              color: Theme.of(context).errorColor,
                            ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
