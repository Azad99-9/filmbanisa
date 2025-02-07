import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmbanisa/models/movie.dart';
import 'package:filmbanisa/models/thread.dart';
import 'package:filmbanisa/services/db_service.dart';
import 'package:filmbanisa/services/thread_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MovieViewModel extends BaseViewModel {
  late Movie movie;

  final ThreadService _threadService = ThreadService();
  final TextEditingController commentTextController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  List<Comment> comments = [];

  bool pageIsLoading = false;
  bool isSubmittingComment = false;

  late Stream<DocumentSnapshot<Object?>> commentsStream;

  Future<void> init(Movie movie) async {
    pageIsLoading = true;
    notifyListeners();
    this.movie = movie;
    commentsStream = DbService.threadsCollection.doc(movie.threadId).snapshots();
    commentsStream.listen((event) async {
      final thread = Thread.fromFirestore(event);
      final allCommentIds = thread.commentIds.toSet();
      final oldCommentIds = comments.map((comment) => comment.id).toSet();
      final newCommentIds = allCommentIds.difference(oldCommentIds);
      final newComments = await Future.wait(newCommentIds.map((id) => _threadService.getComment(id)));
      comments.addAll(newComments);
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 300), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
    });
    await _threadService.createThread(movie);
    comments = await _threadService.getComments(movie.threadId);
    pageIsLoading = false;
    notifyListeners();
  }

  submitComment() async {
    isSubmittingComment = true;
    notifyListeners();
    final newComment = await _threadService.addComment(
        movie.threadId, commentTextController.text);
    // comments.add(newComment);
    commentTextController.clear();
    isSubmittingComment = false;
    notifyListeners();
    // Future.delayed(const Duration(milliseconds: 300), () {
    //   scrollController.animateTo(scrollController.position.maxScrollExtent,
    //       duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    // });
  }
}
