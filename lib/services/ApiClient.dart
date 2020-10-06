import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_movies_app/entities/Movie.dart';

import '../entities/PagedMoviesRequest.dart';

class ApiClient {
  static const API_KEY = 'ef60f290754b298f307a2b64735fddfb';
  static const BASE_API_URL = 'https://api.themoviedb.org/3';
  static const LANG = 'pt-BR';
  static const IMAGE_SIZE = 'w500';

  Future<PagedMoviesRequest> getPopularMovies(int page) async {
    final response = await http.get(
        '$BASE_API_URL/movie/popular?api_key=$API_KEY&language=$LANG&page=$page');
    return PagedMoviesRequest.fromJson(jsonDecode(response.body));
  }

  Future<PagedMoviesRequest> searchMovies(int page, query) async {
    final response = await http.get(
        '$BASE_API_URL/search/movie?api_key=$API_KEY&language=$LANG&query=$query&page=$page&include_adult=true');
    return PagedMoviesRequest.fromJson(jsonDecode(response.body));
  }

  Future<Movie> getMovieDetail(int movieId) async {
    final response = await http
        .get('$BASE_API_URL/movie/$movieId?api_key=$API_KEY&language=$LANG');
    return Movie.fromJson(jsonDecode(response.body));
  }

  String resolveImagePath(String path) {
    return 'https://image.tmdb.org/t/p/$IMAGE_SIZE/$path';
  }
}
