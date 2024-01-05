import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/Functions/FirebaseGroupFunction.dart';
import 'package:hackathon/Utils/Constant.dart';
import 'package:hackathon/Utils/ImagePicker.dart';

class CreateNewGroup extends StatefulWidget {
  const CreateNewGroup({super.key});

  @override
  State<CreateNewGroup> createState() => _CreateNewGroupState();
}

class _CreateNewGroupState extends State<CreateNewGroup> {
  final TextEditingController _groupNameEditingController =
      TextEditingController();
  final TextEditingController _tagsEditingController = TextEditingController();
  String profileUrl = Constant.image;
  File? image;
  List<String> tags = [];

  Future<void> selectImage() async {
    File? imagePath = await pickImageFromGallery(context);
    setState(() {
      image = imagePath;
    });
  }

  _createGroup() async {
    String user = FirebaseAuth.instance.currentUser!.uid;
    profileUrl = await storeFileToFirebase(
        'profilePhoto/group/${_groupNameEditingController.text}', image);
    if (_groupNameEditingController.text.isNotEmpty) {
      FirebaseGroupFunction.createGroup(
          _groupNameEditingController.text, [user], profileUrl, tags, context);
      _groupNameEditingController.clear();
      _tagsEditingController.clear();
    } else {
      print(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Create Group',
          style: TextStyle(
              fontSize: 25, letterSpacing: 3.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: image != null
                        ? FileImage(image!) as ImageProvider<Object>?
                        : NetworkImage(Constant.image),
                    radius: size * 0.15,
                  ),
                  Positioned(
                    bottom: 2,
                    left: 80,
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
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _groupNameEditingController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    prefixIcon: const Icon(Icons.group),
                    hintText: 'GroupName',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _tagsEditingController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          prefixIcon: const Icon(Icons.tag),
                          hintText: 'Enter Tags To Add',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_tagsEditingController.text.isNotEmpty) {
                          setState(() {
                            tags.add(_tagsEditingController.text);
                            _tagsEditingController.clear();
                          });
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      onDeleted: () {
                        setState(() {
                          tags.remove(tag);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  tags.add(_groupNameEditingController.text);
                  _createGroup();
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  width: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    ' Create ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
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
