import 'package:firebase_auth/firebase_auth.dart';

class UserModels {
  String userId;
  String userName;
  String email;
  String collegeName;
  String branchName;
  bool isEmail;
  String profilePhoto;
  bool isOnline;

  UserModels(
      {required this.email,
      required this.userId,
      required this.userName,
      required this.collegeName,
      required this.branchName,
      required this.isEmail,
      required this.isOnline,
      required this.profilePhoto});

  factory UserModels.fromJson(Map<String, dynamic> json) {
    return UserModels(
      userId: json['userId'] ?? '',
      email: json['userEmail'] ?? '',
      userName: json['userName'] ?? '',
      collegeName: json['collegeName'] ?? '',
      branchName: json['branchName'] ?? '',
      isEmail: json['isEmail'] ?? false,
      isOnline: json['isOnline'] ?? false,
      profilePhoto: json['profilePhoto'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userEmail': email,
      'userName': userName,
      'collegeName': collegeName,
      'branchName': branchName,
      'isEmail': isEmail,
      'isOnline': isOnline,
      'profilePhoto': profilePhoto,
    };
  }
}
