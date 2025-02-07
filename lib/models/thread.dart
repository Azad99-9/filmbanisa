import 'package:cloud_firestore/cloud_firestore.dart';

class Thread {
  final String id;
  final String title;
  final String content;
  final String authorId;
  final String authorName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int replyCount;
  final List<String> commentIds;
  final bool isLocked;

  Thread({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    required this.updatedAt,
    this.replyCount = 0,
    this.commentIds = const [],
    this.isLocked = false,
  });

  // Create Thread from Firestore document
  factory Thread.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return Thread(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      authorId: data['authorId'] ?? '',
      authorName: data['authorName'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      replyCount: data['replyCount'] ?? 0,
      commentIds: List<String>.from(data['commentIds'] ?? []),
      isLocked: data['isLocked'] ?? false,
    );
  }

  // Convert Thread to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'authorId': authorId,
      'authorName': authorName,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'replyCount': replyCount,
      'commentIds': commentIds,
      'isLocked': isLocked,
    };
  }

  // Add method to fetch comments
  Future<List<Comment>> fetchComments() async {
    final commentsSnapshot = await Future.wait(
      commentIds.map((commentId) => 
        FirebaseFirestore.instance
          .collection('comments')
          .doc(commentId)
          .get()
      )
    );
    
    return commentsSnapshot
      .where((doc) => doc.exists)
      .map((doc) => Comment.fromFirestore(doc))
      .toList();
  }

  // Create a copy of Thread with modified fields
  Thread copyWith({
    String? title,
    String? content,
    String? authorId,
    String? authorName,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? replyCount,
    List<String>? commentIds,
    bool? isLocked,
  }) {
    return Thread(
      id: this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      replyCount: replyCount ?? this.replyCount,
      commentIds: commentIds ?? this.commentIds,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}

class Comment {
  String id;
  final String userId;
  final String userName;
  final String content;
  final List<String> likes;
  final int reviewCoins;
  final String threadId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> taggedPeople;

  Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.content,
    this.likes = const [],
    this.reviewCoins = 0,
    required this.threadId,
    required this.createdAt,
    required this.updatedAt,
    this.taggedPeople = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'content': content,
      'likes': likes,
      'reviewCoins': reviewCoins,
      'threadId': threadId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'taggedPeople': taggedPeople,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      content: map['content'] ?? '',
      likes: List<String>.from(map['likes'] ?? []),
      reviewCoins: map['reviewCoins'] ?? 0,
      threadId: map['threadId'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      taggedPeople: List<String>.from(map['taggedPeople'] ?? []),
    );
  }

  factory Comment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Comment(
      id: doc.id,
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      content: data['content'] ?? '',
      likes: List<String>.from(data['likes'] ?? []),
      reviewCoins: data['reviewCoins'] ?? 0,
      threadId: data['threadId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      taggedPeople: List<String>.from(data['taggedPeople'] ?? []),
    );
  }
}

