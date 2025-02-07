import 'package:cloud_firestore/cloud_firestore.dart';

class MovieType {
  static const String movie = 'movie';
  static const String webSeries = 'webSeries';
}

class Movie {
  final String id;
  final String title;
  final String description;
  final String posterUrl;
  final String releaseDate;
  final String type;
  final double rating;
  final List<String> genres;
  final String threadId;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
    required this.releaseDate,
    required this.type,
    required this.rating,
    required this.genres,
    required this.threadId,
  });

  // Convert Movie to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'posterUrl': posterUrl,
      'releaseDate': releaseDate,
      'type': type,
      'rating': rating,
      'genres': genres,
      'threadId': threadId,
    };
  }

  // Create Movie from Firestore document
  factory Movie.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Movie(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      posterUrl: data['posterUrl'] ?? '',
      releaseDate: data['releaseDate'] ?? '',
      type: data['type'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      genres: List<String>.from(data['genres'] ?? []),
      threadId: data['threadId'] ?? '',
    );
  }
}

