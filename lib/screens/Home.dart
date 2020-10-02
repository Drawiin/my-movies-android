import 'package:flutter/material.dart';
import 'package:my_movies_app/components/LoadingPlaceholder.dart';
import 'package:my_movies_app/components/MovieCard.dart';
import 'package:my_movies_app/entities/Movie.dart';
import 'package:my_movies_app/repositories/MoviesRepository.dart';
import 'package:my_movies_app/services/ApiClient.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _apiClient = ApiClient();
  final moviesRepository = MoviesRepository();
  final _movies = <Movie>[];
  final _favorites = <Movie>[];
  int _currentPage;
  int _totalPages;

  _reload() async {
    final popularMovies = await _apiClient.getPopularMovies(1);
    setState(() {
      _currentPage = 1;
      _totalPages = popularMovies.totalPages;
      _movies.clear();
      _movies.addAll(popularMovies.results);
    });
  }

  _loadNextPage() async {
    if ((_currentPage + 1) > _totalPages) return;
    final popularMovies = await _apiClient.getPopularMovies(_currentPage + 1);
    setState(() {
      _totalPages = popularMovies.totalPages;
      _currentPage++;
      _movies.addAll(popularMovies.results);
    });
  }

  loadFavorites() async {
    final favorites = await moviesRepository.loadFavoriteMovies();
    setState(() {
      _favorites.clear();
      _favorites.addAll(favorites);
    });
  }

  _saveFavorites() async {
    moviesRepository.saveFavoriteMovies(_favorites);
  }

  _addToFavorite(Movie movie) {
    setState(() {
      _favorites.add(movie);
      _saveFavorites();
    });
  }

  _removeFromFavorite(int movieId) {
    setState(() {
      _favorites.removeWhere((movie) => movie.id == movieId);
      _saveFavorites();
    });
  }

  _isFavorite(Movie movie) {
    return _favorites.indexWhere((element) => element.id == movie.id) > -1;
  }

  Widget itemBuilder(BuildContext context, int index) {
    if (index == _movies.length) return LoadingPlaceholder();

    if (index == _movies.length - 1) _loadNextPage();

    return MovieCard(_movies[index], _removeFromFavorite, _addToFavorite,
        _isFavorite(_movies[index]));
  }

  @override
  void initState() {
    super.initState();
    _totalPages = 1;
    loadFavorites();
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return _movies.isEmpty
        ? LoadingPlaceholder()
        : ListView.builder(
            padding: EdgeInsets.only(left: 8, right: 8),
            itemBuilder: itemBuilder,
            itemCount: _movies.length + 1,
          );
  }
}
