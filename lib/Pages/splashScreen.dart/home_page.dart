import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/Functions/user_functions.dart';
import 'package:hackathon/Models/userModels.dart';
import 'package:hackathon/Pages/groupChat/GroupHome.dart';
import 'package:hackathon/Provider/UserProvider.dart';
import 'package:hackathon/Utils/Indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  late Widget page = GroupHome();
  late String? uid;
  late UserModels? user;

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
    print(uid);
    getUser();
  }

  void getUser() async {
    UserModels? userref = await UserFunction.getCurrentUser(uid);
    setState(() {
      user = userref;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, user, _) {
      return (!user.isUser)
          ? const Indicator()
          : Scaffold(
              body: page,
              bottomNavigationBar: BottomNavigationBar(
                elevation: 10,
                selectedItemColor: const Color.fromARGB(255, 240, 230, 138),
                unselectedItemColor: Colors.grey.shade400,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.group), label: 'Groups'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: 'Search'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.audio_file), label: 'Meeting'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.work), label: 'ToDo'),
                ],
                currentIndex: index,
                onTap: (int tappedIndex) {
                  setState(() {
                    index = tappedIndex;
                  });

                  switch (index) {
                    case 0:
                      setState(() {
                        page = GroupHome();
                      });
                      break;
                    case 1:
                      setState(() {
                        // page = const SearchScreen();
                      });
                      break;
                    case 2:
                      setState(() {
                        // page = const MeetingHome();
                      });
                      break;
                    case 3:
                      setState(() {
                        // page = const ToDoHome();
                      });
                      break;
                    default:
                      break;
                  }
                },
              ),
            );
    });
  }
}
