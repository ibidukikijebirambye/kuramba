import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import '../widgets/auth_form.dart';
import '../widgets/dialogs/custom_error_dialog.dart';

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String username,
    File image,
    String password,
    bool login,
  ) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (login) {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final ref = FirebaseStorage.instance.ref().child('user_images').child(
              '${userCredential.user.uid}.jpg',
            );
        await ref.putFile(image);
        final url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set(
          {
            'username': username,
            'email': email,
            'image_url': url,
          },
        );
      }
    } on PlatformException catch (error) {
      setState(() {
        _isLoading = false;
      });
      var message = 'An error occurred. Please check your credentials!';
      if (error.message != null) {
        message = error.message;
      }
      showDialog(
        context: context,
        builder: (context) => CustomErrorDialog(message),
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      var message = 'An error occurred. Please check your credentials!';
      if (error.message != null) {
        message = error.message;
      }
      showDialog(
        context: context,
        builder: (context) => CustomErrorDialog(message),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(
                          0.7,
                        ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: AuthForm(
                _submitAuthForm,
                _isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
