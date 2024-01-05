import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/Functions/user_functions.dart';
import 'package:hackathon/Models/userModels.dart';

class UserProvider extends ChangeNotifier {
  UserModels? user;
  bool isUser = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  UserProvider() {
    initialize();
  }

  void initialize() async {
    print('function initialize');
    print(isUser);
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        uid = FirebaseAuth.instance.currentUser!.uid;
        print(uid);
        user = await UserFunction.getCurrentUser(uid);
        if (user != null) {
          if (user!.userId != null) {
            print('user name is equal to : ${user?.userName}');
            print('user is equal to : $user');

            isUser = true;
            print('function gets up');
            print(isUser);

            notifyListeners();
          } else {
            print('User ID is null');
          }
        } else {
          print('User is null');
        }
      } else {
        print('No authenticated user');
      }
    } catch (error) {
      print('Error during initialization: $error');
    }
  }

  void emailVerfication() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'isEmail': true});

    user?.isEmail = true;
    notifyListeners();
  }

  void signOut() {
    isUser = false;
    user = null;
    print(isUser);
    print(user);
    notifyListeners();
  }
}
