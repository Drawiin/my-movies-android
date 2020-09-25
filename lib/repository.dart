import 'dart:convert';

import 'package:http/http.dart' as http;

import 'entities.dart';

class MoviesRepository {
  static const API_KEY = 'ef60f290754b298f307a2b64735fddfb';
  static const LANGUAGE = 'pt-BR';

  Future<PopularMovies> loadMovies(int page) async {
    final response = await http.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY&language=$LANGUAGE&page=$page');
    return PopularMovies.fromJson(jsonDecode(response.body));
  }

  String resolveImagePath(String path){
    return 'https://image.tmdb.org/t/p/w300/$path';
  }
}
