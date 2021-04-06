import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'providers/theme_provider.dart';
import 'providers/current_user_provider.dart';

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
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return ThemeProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return CurrentUserProvider();
          },
        ),
      ],
      child: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (
          context,
          appSnapshot,
        ) {
          return FutureBuilder(
            future: Provider.of<ThemeProvider>(
              context,
              listen: false,
            ).fetchThemeData(),
            builder: (
              context,
              themeSnapshot,
            ) {
              return MaterialApp(
                title: 'Kuramba',
                themeMode: Provider.of<ThemeProvider>(context).currentThemeMode,
                theme: Provider.of<ThemeProvider>(context).theme,
                darkTheme: Provider.of<ThemeProvider>(context).darkTheme,
                debugShowCheckedModeBanner: false,
                home: appSnapshot.connectionState != ConnectionState.done ||
                        themeSnapshot.connectionState != ConnectionState.done
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
          );
        },
      ),
    );
  }
}
