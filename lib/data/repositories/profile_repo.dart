import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart" as fbauth;

import "package:ask_chatgpt/presentation/constants/firestore_ref.dart";

import '../models/exports/models_exports.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbauth.FirebaseAuth firebaseAuth;

  ProfileRepository(
      {required this.firebaseAuth, required this.firebaseFirestore});

  Future<User> fetchProfile({required String userId}) async {
    try {
      final userDoc = await FirestoreRef.userRef.doc(userId).get();
      final user = User.fromDoc(userDoc);
      return user;
    } on fbauth.FirebaseAuthException catch (e) {
      throw CustomError(
          errorMessage: e.message!, code: e.code, plugin: e.plugin);
    }
  }
}
