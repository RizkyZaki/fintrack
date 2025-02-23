import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthBloc extends Cubit<User?> {
  AuthBloc() : super(null);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(userCredential.user);
    } catch (e) {
      debugPrint('Register Error: $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(userCredential.user);
    } catch (e) {
      debugPrint('Login Error: $e');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    emit(null);
  }
}
