import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference get usersCollection => _firestore.collection('users');
  static CollectionReference get moviesCollection => _firestore.collection('movies');
  static CollectionReference get commentsCollection => _firestore.collection('comments');
  static CollectionReference get threadsCollection => _firestore.collection('threads');
}
