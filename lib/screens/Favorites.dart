import 'package:flutter/material.dart';
import 'package:my_movies_app/components/MovieCard.dart';
import 'package:my_movies_app/entities/entities.dart';
import 'package:my_movies_app/services/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  static const FAVORITES_KEY = "FAVORITES_KEY";
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  final _favorites = <int>[];
  int _currentPage;
  int _totalPages;

  _reload() async {
    final popularMovies = await _apiClient.loadMovies(1);
    setState(() {
      _currentPage = 1;
      _totalPages = popularMovies.totalPages;
      _movies.clear();
      _movies.addAll(popularMovies.results);
    });
  }

  _loadNextPage() async {
    if ((_currentPage + 1) > _totalPages) return;
    final popularMovies = await _apiClient.loadMovies(_currentPage + 1);
    setState(() {
      _totalPages = popularMovies.totalPages;
      _currentPage++;
      _movies.addAll(popularMovies.results);
    });
  }

  _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final loadedFavorites = prefs.getStringList(FAVORITES_KEY) ?? <String>[];
    setState(() {
      _favorites.addAll(loadedFavorites.map((e) => int.parse(e)).toList());
    });
  }

  _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        FAVORITES_KEY, _favorites.map((e) => e.toString()).toList());
  }

  _addToFavorite(int movieId) {
    setState(() {
      _favorites.add(movieId);
    });
    _saveFavorites();
  }

  _removeFromFavorite(int movieId) {
    setState(() {
      _favorites.removeWhere((id) => id == movieId);
    });
    _saveFavorites();
  }

  _isFavorite(int movieId) {
    return _favorites.contains(movieId);
  }

  Widget _loadingPlaceholder() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void initState() {
    super.initState();
    _totalPages = 1;
    _loadFavorites();
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return _movies.isEmpty
        ? _loadingPlaceholder()
        : ListView.builder(
      padding: EdgeInsets.only(left: 8, right: 8),
      itemBuilder: (context, index) {
        if (index == _movies.length) return _loadingPlaceholder();

        if (index == _movies.length - 1) _loadNextPage();

        return MovieCard(_movies[index], _removeFromFavorite,
            _addToFavorite, _isFavorite(_movies[index].id));
      },
      itemCount: _movies.length + 1,
    );
  }
}
