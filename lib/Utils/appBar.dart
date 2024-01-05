import 'package:flutter/material.dart';
import 'package:hackathon/Provider/UserProvider.dart';
import 'package:hackathon/Utils/CompanyLogo.dart';
import 'package:hackathon/Utils/Constant.dart';
import 'package:provider/provider.dart';

Widget appBar(String title, BuildContext context) {
  var user = Provider.of<UserProvider>(context, listen: false);
  return AppBar(
    leading: Padding(
        padding: const EdgeInsets.only(left: 10), child: CompanyLogo(10, 20)),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 251, 242, 161),
      ),
    ),
    centerTitle: true,
    actions: [
      GestureDetector(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const AccountScreen()));
        },
        child: CircleAvatar(
          radius: 23,
          backgroundColor: const Color.fromARGB(255, 246, 236, 145),
          child: CircleAvatar(
            radius: 20,
            backgroundImage:
                NetworkImage(user.user?.profilePhoto ?? Constant.image),
          ),
        ),
      ),
      const SizedBox(
        width: 20,
      ),
    ],
  );
}
