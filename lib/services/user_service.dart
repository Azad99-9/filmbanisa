

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmbanisa/models/user.dart';
import 'package:filmbanisa/services/db_service.dart';

class UserService {
  final CollectionReference _userCollection = DbService.usersCollection;
  Future<void> createUser(UserModel user) async {
    await _userCollection.doc(user.id).set(user.toJson());
  }

  Future<UserModel?> getUser(String uid) async {
    final snapshot = await _userCollection.doc(uid).get();
    return snapshot.exists ? UserModel.fromJson(snapshot.data() as Map<String, dynamic>) : null;
  }
}
