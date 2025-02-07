import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmbanisa/models/movie.dart';
import 'package:filmbanisa/services/db_service.dart';

class MoviesService {
  static final CollectionReference _moviesCollection =
      DbService.moviesCollection;
  static Future<List<Movie>> getMovies() async {
    return await _moviesCollection.get().then(
        (value) => value.docs.map((e) => Movie.fromFirestore(e)).toList());
  }

  
}
