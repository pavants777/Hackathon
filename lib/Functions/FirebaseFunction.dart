import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon/Models/GroupModels.dart';

class FirebaseFunction {
  static Future<GroupModels> getGroup(String groupId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('groups')
        .doc(groupId)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data();

      if (data != null) {
        dynamic usersData = data['users'];
        dynamic tagsData = data['tags'];

        List<String> usersList;
        List<String> tagsList;

        if (usersData is List) {
          usersList = List<String>.from(usersData);
        } else if (usersData is String) {
          usersList = (json.decode(usersData) as List<dynamic>).cast<String>();
        } else {
          usersList = [];
        }

        if (tagsData is List) {
          tagsList = List<String>.from(tagsData);
        } else if (tagsData is String) {
          tagsList = (json.decode(tagsData) as List<dynamic>).cast<String>();
        } else {
          throw Exception("Unexpected type for 'Tags' field");
        }

        return GroupModels(
          groupId: data['groupId'] ?? '',
          groupName: data['groupName'] ?? '',
          profileUrl: data['profileUrl'],
          lastMessage: data['lastMessage'],
          users: usersList,
          tags: tagsList,
          lasttimestamp: data['lasttimestamp'] != null
              ? (data['lasttimestamp'] as Timestamp).toDate()
              : null,
          isAdmin: data['isAdmin'] ?? '',
        );
      } else {
        throw Exception("Data is null for group with id $groupId");
      }
    } else {
      throw Exception("Group with id $groupId does not exist");
    }
  }

  static Stream<List<GroupModels>> getGroups() async* {
    yield* FirebaseFirestore.instance
        .collection('groups')
        .orderBy('lasttimestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => GroupModels.fromJson(doc.data()))
          .toList();
    });
  }
}
