import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/global/user_model.dart';
import 'package:hive/hive.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> filteredUsers = [];
  bool superAdmin = false;

  Future<void> statusAdminh() async {
    final box = Hive.box<UserModel>('users');

    if (box.isNotEmpty) {
      UserModel user = box.getAt(0)!;

      superAdmin = user.superAdmin ?? false;
      notifyListeners();
    }
  }

  Future<void> fetchUsers() async {
    statusAdminh();

    final snapshot = await _firestore.collection('Users').get();
    _allUsers = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();

    filteredUsers = List.from(_allUsers);
    notifyListeners();
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      filteredUsers = List.from(_allUsers);
    } else {
      filteredUsers = _allUsers
          .where((user) =>
              user['nombre'] != null &&
              user['nombre'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> deleteUser(String userId) async {
    await _firestore.collection('Users').doc(userId).delete();
    _allUsers.removeWhere((user) => user['id'] == userId);
    filteredUsers.removeWhere((user) => user['id'] == userId);
    notifyListeners();
  }

  Future<void> updateUserStatus(String userId, String newStatus) async {
    await _firestore.collection('Users').doc(userId).update({
      'Estado': newStatus,
    });

    final userIndex = _allUsers.indexWhere((user) => user['id'] == userId);
    if (userIndex != -1) {
      _allUsers[userIndex]['Estado'] = newStatus;
    }

    final filteredUserIndex =
        filteredUsers.indexWhere((user) => user['id'] == userId);
    if (filteredUserIndex != -1) {
      filteredUsers[filteredUserIndex]['Estado'] = newStatus;
    }

    notifyListeners();
  }
}
