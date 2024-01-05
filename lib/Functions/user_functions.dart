import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/Models/userModels.dart';
import 'package:hackathon/Provider/UserProvider.dart';
import 'package:hackathon/Routes/routes.dart';
import 'package:hackathon/Utils/Get_snackBar.dart';
import 'package:provider/provider.dart';

class UserFunction {
  static Future<void> login(
      String email, password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Provider.of<UserProvider>(context, listen: false).initialize();
      Navigator.pushReplacementNamed(context, Routes.homePage);
    } on FirebaseAuthException catch (e) {
      GetXSnackbar("Error in Login Page", "${e.message}");
    }
  }

  static Future<void> signIn(
      String email, password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, Routes.userSetup);
    } on FirebaseAuthException catch (e) {
      GetXSnackbar("Error in SigIn", e.message);
    }
  }

  static createUserInfo(
      String userName, url, collegeName, branch, isOnline, isEmail) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String email = FirebaseAuth.instance.currentUser?.email ?? "Unknown";

    UserModels data = UserModels(
        userId: uid,
        userName: userName,
        email: email,
        collegeName: collegeName,
        branchName: branch,
        isEmail: isEmail,
        isOnline: isOnline,
        profilePhoto: url);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(data.toMap());
  }

  static Future<UserModels?> getCurrentUser(String? userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .where('userId', isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        if (data != null) {
          print(data);
          return UserModels.fromJson(data);
        }
      }
      return null;
    } catch (error) {
      print('Error in getCurrentUser: $error');
      return null;
    }
  }
}
