import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String userName;
  final String password;
  final String authType;
  final String profileImage;

  const User({
    required this.email,
    required this.userName,
    required this.password,
    required this.authType,
    required this.profileImage,
  });

  factory User.initial() => const User(
        email: "",
        userName: "",
        password: "",
        authType: "",
        profileImage: "",
      );

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>;

    return User(
      email: userData['email'],
      userName: userData['fullName'],
      password: "",
      authType: userData['auth_type'],
      profileImage: userData['profileImage'],
    );
  }

  @override
  List<Object?> get props => [
        email,
        userName,
        password,
        authType,
        profileImage,
      ];

  @override
  String toString() {
    return 'User{email: $email, fullName: $userName, password: $password, authType: $authType, profileImage: $profileImage}';
  }

  User copyWith({
    String? email,
    String? fullName,
    String? password,
    String? authType,
    String? profileImage,
  }) {
    return User(
      email: email ?? this.email,
      userName: fullName ?? userName,
      password: password ?? this.password,
      authType: authType ?? this.authType,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
