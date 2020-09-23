import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential user;
  User _user;

  _signInWithEmailAndPass(String email, String pass) async {
    user = await _auth.signInWithEmailAndPassword(email: email, password: pass);
    _user = _auth.currentUser;
    return _user.uid;
  }

  _createUser(String email, String pass) async {
    user = await _auth.createUserWithEmailAndPassword(
        email: email, password: pass);
    _user = _auth.currentUser;
    return _user.uid;
  }
}
