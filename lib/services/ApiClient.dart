import 'dart:convert';

import 'package:http/http.dart' as http;

import '../entities/entities.dart';

class ApiClient {
  static const API_KEY = 'ef60f290754b298f307a2b64735fddfb';
  static const LANGUAGE = 'pt-BR';

  Future<PopularMoviesRequest> loadMovies(int page) async {
    final response = await http.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY&language=$LANGUAGE&page=$page');
    return PopularMoviesRequest.fromJson(jsonDecode(response.body));
  }

  Future<Movie> getMovieDetail(int movieId) async {
    final response = await http.get(
        'https://api.themoviedb.org/3/movie/$movieId?api_key=$API_KEY&language=$LANGUAGE');
    return Movie.fromJson(jsonDecode(response.body));
  }

  String resolveImagePath(String path) {
    return 'https://image.tmdb.org/t/p/w300/$path';
  }
}
