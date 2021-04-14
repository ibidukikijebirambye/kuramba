import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String email;
  final String username;
  final String imageURL;
  final List<String> contacts;

  UserData({
    @required this.email,
    @required this.username,
    @required this.imageURL,
    @required this.contacts,
  });
}

class CurrentUser with ChangeNotifier {
  UserData _user;

  UserData get user {
    return UserData(
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
      _user = UserData(
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

  Future<void> addToContacts(String email) async {
    try {
      final fb = FirebaseFirestore.instance;
      final contactDoc = (await fb
              .collection('users')
              .where(
                'email',
                isEqualTo: email,
              )
              .limit(1)
              .get())
          .docs[0];
      return fb
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('contacts')
          .doc(contactDoc.id)
          .set({});
    } catch (error) {
      throw error;
    }
  }
}
