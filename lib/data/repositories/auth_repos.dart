import 'package:ask_chatgpt/data/models/custom_error.dart';
import 'package:ask_chatgpt/presentation/constants/firestore_ref.dart';
import 'package:ask_chatgpt/presentation/resources/assets_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  AuthRepository({required this.firebaseAuth, required this.firebaseFirestore});

  Stream<User?> get user => firebaseAuth.userChanges();
  var error = "Error occurred!";

  // sign up
  Future<void> signUp(
      {required String email,
      required String userName,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirestoreRef.userRef.doc(userCredential.user!.uid).set({
        'id': userCredential.user!.uid,
        'userName': userName,
        'email': email,
        'profileImage':
            ImageAssets.avatarUrl,
        'auth_type': 'email/password'
      });
    } on FirebaseAuthException catch (e) {
      throw CustomError(
          errorMessage: "${e.message}", code: e.code, plugin: e.plugin);
    } on CustomError catch (e) {
      throw CustomError(
        errorMessage: e.errorMessage,
        code: 'Exception',
        plugin: 'Firebase/Exception',
      );
    }
  }

  // sign in
  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw CustomError(
          errorMessage: "${e.message}", code: e.code, plugin: e.plugin);
    } on CustomError catch (e) {
      throw CustomError(
        errorMessage: e.errorMessage,
        code: 'Exception',
        plugin: 'Firebase/Exception',
      );
    }
  }

  // google auth
  Future<void> googleAuth() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final logCredentials =
          await firebaseAuth.signInWithCredential(credential);
      final user = logCredentials.user;

      FirestoreRef.userRef.doc(user!.uid).set({
        'id': user.uid,
        'email': user.email,
        'userName': user.displayName,
        'profileImage': user.photoURL,
        'auth_type': 'GoogleAuth',
      });
    } on PlatformException catch (e) {
      throw CustomError(
          code: e.code,
          errorMessage: "${e.message}",
          plugin: 'firebase/exception');
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        errorMessage: error,
        plugin: 'firebase_exception/server_error',
      );
    }
  }

  // forgotPassword
  Future<void> forgotPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw CustomError(
          code: e.code, errorMessage: e.message!, plugin: e.plugin);
    } on CustomError catch (e) {
      throw CustomError(
        code: 'Exception',
        errorMessage: e.toString(),
        plugin: 'firebase_exception/server_error',
      );
    }
  }

  // sign out
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        errorMessage: e.toString(),
        plugin: 'firebase_exception/server_error',
      );
    }
  }
}
