import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String imageURL;
  final List<String> contacts;

  User({
    @required this.email,
    @required this.username,
    @required this.imageURL,
    @required this.contacts,
  });
}

class CurrentUserProvider with ChangeNotifier {
  User _user;

  User get user {
    return User(
      email: _user.email,
      username: _user.username,
      imageURL: _user.imageURL,
      contacts: _user.contacts,
    );
  }

  Future<void> fetchData() async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get();
      final userContacts = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('contacts')
          .get();
      _user = User(
        email: userData.data()['email'],
        username: userData.data()['username'],
        imageURL: userData.data()['image_url'],
        contacts: userContacts.docs.map(
          (contactDoc) {
            return contactDoc.id;
          },
        ).toList(),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
