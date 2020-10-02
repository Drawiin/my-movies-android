import 'dart:convert';

import 'package:my_movies_app/entities/Movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoviesRepository {
  static const FAVORITES_KEY = "FAVORITES_KEY";

  void saveFavoriteMovies(List<Movie> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        FAVORITES_KEY, favorites.map((movie) => movie.toJson()).toList());
  }

  Future<List<Movie>> loadFavoriteMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final loadedFavorites = prefs.getStringList(FAVORITES_KEY) ?? <String>[];
    return loadedFavorites
        .map((movie) => Movie.fromJson(jsonDecode(movie)))
        .toList();
  }
}
