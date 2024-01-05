import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/Functions/user_functions.dart';
import 'package:hackathon/Provider/UserProvider.dart';
import 'package:hackathon/Routes/routes.dart';
import 'package:hackathon/Utils/Constant.dart';
import 'package:hackathon/Utils/ImagePicker.dart';
import 'package:hackathon/Utils/Indicator.dart';
import 'package:provider/provider.dart';

class UserSetUP extends StatefulWidget {
  const UserSetUP({
    Key? key,
  }) : super(key: key);

  @override
  State<UserSetUP> createState() => _UserSetUPState();
}

class _UserSetUPState extends State<UserSetUP> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _collegeName = TextEditingController();
  final TextEditingController _branch = TextEditingController();
  File? image;

  Future<void> selectImage() async {
    File? imagePath = await pickImageFromGallery(context);
    setState(() {
      image = imagePath;
    });
  }

  String profileUrl = Constant.image;

  setUserSetUp() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    profileUrl = await storeFileToFirebase('profilePhoto/$uid', image);
    UserFunction.createUserInfo(_userName.text, profileUrl, _collegeName.text,
        _branch.text, true, false);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User SetUp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: image != null
                        ? FileImage(image!) as ImageProvider<Object>?
                        : NetworkImage(Constant.image),
                    radius: size * 0.25,
                  ),
                  Positioned(
                    bottom: 10,
                    left: 150,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _userName,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    prefixIcon: const Icon(Icons.school),
                    hintText: 'UserName',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _collegeName,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    prefixIcon: const Icon(Icons.school),
                    hintText: 'College Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _branch,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    prefixIcon: const Icon(Icons.book),
                    hintText: 'Branch',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () async {
                  setUserSetUp();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Indicator()));
                  await Future.delayed(const Duration(seconds: 5));
                  Provider.of<UserProvider>(context, listen: false)
                      .initialize();
                  Navigator.pushReplacementNamed(context, Routes.homePage);
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Text(
                    'Let\'s Start',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
