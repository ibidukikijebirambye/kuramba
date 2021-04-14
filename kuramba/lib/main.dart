import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'providers/dynamic_theme.dart';
import 'providers/current_user.dart';

import 'views/auth_view.dart';
import 'views/splash_screen.dart';
import 'views/main_view.dart';

import 'config/routes.dart';

void main() async {
  // temporarily disabled landscape mode due to the lack of responsiveness
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(Kuramba());
}

class Kuramba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DynamicTheme(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrentUser(),
        ),
      ],
      builder: (context, child) => FutureBuilder(
        future: Future.wait(
          [
            Firebase.initializeApp(),
            Provider.of<DynamicTheme>(context, listen: false).fetchThemeData(),
          ],
        ),
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Kuramba',
            themeMode: Provider.of<DynamicTheme>(context).currentThemeMode,
            theme: Provider.of<DynamicTheme>(context).theme,
            darkTheme: Provider.of<DynamicTheme>(context).darkTheme,
            debugShowCheckedModeBanner: false,
            home: snapshot.connectionState != ConnectionState.done
                ? SplashScreen()
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, authSnapshot) {
                      return authSnapshot.hasData ? MainView() : AuthView();
                    },
                  ),
            routes: routes,
          );
        },
      ),
    );
  }
}
