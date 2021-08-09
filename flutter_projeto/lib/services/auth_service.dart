import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthExecption implements Exception {
  String message;
  AuthExecption(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(String login, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: login, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthExecption('A senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthExecption('Este e-mail já está cadastrado');
      }
    }
  }

  login(String login, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: login, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthExecption('Login e/ou senha incorretos');
      } else if (e.code == 'wrong-password') {
        throw AuthExecption('Login e/ou senha incorretos');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
