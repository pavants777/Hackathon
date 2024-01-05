import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/Utils/Get_snackBar.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    GetXSnackbar("Error while Uploading Photo", e);
  }
  return image;
}

Future<String> storeFileToFirebase(String path, File? file) async {
  UploadTask uploadTask =
      FirebaseStorage.instance.ref().child(path).putFile(file!);
  TaskSnapshot snap = await uploadTask;
  String downloadUrl = await snap.ref.getDownloadURL();
  return downloadUrl;
}
