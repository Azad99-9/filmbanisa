import 'dart:async';

import 'package:filmbanisa/models/movie.dart';
import 'package:filmbanisa/services/movies_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  List<Movie> latestMovies = [];
  List<Movie> movies = [];
  List<Movie> webSeries = [];

  Future<void> init() async {
    await fetchMovies();
  }

  Future<void> fetchMovies() async {
    final entities = await MoviesService.getMovies();
    latestMovies = entities.where((entity) => entity.type == MovieType.movie).toList();
    movies = latestMovies;
    webSeries = entities.where((entity) => entity.type == MovieType.webSeries).toList();
    notifyListeners();
  }


  // searchQueryBuilder(String query) {
  //   searchQuery = query;
  //   searchMovies = movies.where((movie) => movie.title.contains(query)).toList();
  //   notifyListeners();
  // }
}
