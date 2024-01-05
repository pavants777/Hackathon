import 'package:flutter/material.dart';
import 'package:hackathon/Pages/splashScreen.dart/LoginPage.dart';
import 'package:hackathon/Pages/splashScreen.dart/SignIn.dart';
import 'package:hackathon/Pages/splashScreen.dart/home_page.dart';
import 'package:hackathon/Pages/splashScreen.dart/userDetails.dart';
import 'package:hackathon/main.dart';

class Routes {
  static String startpage = '/';
  static String loginPage = '/login';
  static String signIn = '/signIn';
  static String homePage = '/home';
  static String userSetup = '/userUpdate';

  static Map<String, WidgetBuilder> routes = {
    startpage: (context) => StartPage(),
    loginPage: (context) => LoginPage(),
    signIn: (context) => SignIn(),
    homePage: (context) => HomePage(),
    userSetup: (context) => UserSetUP(),
  };
}
