import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmbanisa/models/movie.dart';
import 'package:filmbanisa/models/thread.dart';
import 'package:filmbanisa/services/auth_service.dart';
import 'package:filmbanisa/services/db_service.dart';
import 'package:uuid/uuid.dart';

class ThreadService {
  final CollectionReference _threadsCollection = DbService.threadsCollection;
  final CollectionReference _commentsCollection = DbService.commentsCollection;

  Future<void> createThread(Movie movie) async {
    final docRef = _threadsCollection.doc(movie.threadId);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      return;
    }

    final Thread thread = Thread(
      id: movie.threadId,
      title: movie.title,
      content: 'Start thread',
      authorId: AuthService.currentUser!.uid,
      authorName: AuthService.currentUser!.displayName ?? 'Anonymous',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await docRef.set(thread.toFirestore());
  }

  Future<void> updateThread(String threadId, Map<String, dynamic> data) async {
    final docRef = _threadsCollection.doc(threadId);
    await docRef.update(data);
  }

  Future<List<Comment>> getComments(String threadId) async {
    final thread =
        Thread.fromFirestore(await _threadsCollection.doc(threadId).get());
    return await thread.fetchComments();
  }

  Future<Comment> addComment(String threadId, String comment) async {
    final Comment newComment = Comment(
      id: const Uuid().v4(),
      userId: AuthService.currentUser!.uid,
      userName: AuthService.currentUser!.displayName ?? 'Anonymous',
      content: comment,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      threadId: threadId,
    );

    final newCommentDocRef = _commentsCollection.doc(newComment.id);
    await newCommentDocRef.set(newComment.toMap());

    updateThread(threadId, {
      'updatedAt': DateTime.now(),
      'commentIds': FieldValue.arrayUnion([newComment.id]),
    });

    return newComment;
  }

  Future<Comment> getComment(String commentId) async {
    final docRef = _commentsCollection.doc(commentId);
    final docSnapshot = await docRef.get();
    return Comment.fromFirestore(docSnapshot);
  }

  Future<void> updateComment(
      String commentId, Map<String, dynamic> data) async {
    final docRef = _commentsCollection.doc(commentId);
    await docRef.update(data);
  }
}
