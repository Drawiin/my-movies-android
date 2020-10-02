import 'package:flutter/material.dart';
import 'package:my_movies_app/components/MovieCard.dart';
import 'package:my_movies_app/entities/Movie.dart';
import 'package:my_movies_app/repositories/MoviesRepository.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final _favorites = <Movie>[];
  final moviesRepository = MoviesRepository();

  loadFavorites() async {
    final favorites = await moviesRepository.loadFavoriteMovies();
    setState(() {
      _favorites.clear();
      _favorites.addAll(favorites);
    });
  }

  updateFavorites() async {
    moviesRepository.saveFavoriteMovies(_favorites);
  }

  removeFromFavorite(int movieId) {
    setState(() {
      _favorites.removeWhere((movie) => movie.id == movieId);
      updateFavorites();
    });
  }

  isFavorite(Movie movie) {
    return _favorites.indexWhere((element) => element.id == movie.id) > -1;
  }

  Widget emptyMassage() {
    return Center(
      child: Text('Você ainda não tem favoritos'),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return MovieCard(_favorites[index], removeFromFavorite, (movie) {},
        isFavorite(_favorites[index]));
  }

  @override
  void initState() {
    loadFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _favorites.isEmpty
        ? emptyMassage()
        : ListView.builder(
            padding: EdgeInsets.only(left: 8, right: 8),
            itemBuilder: itemBuilder,
            itemCount: _favorites.length,
          );
    ;
  }
}
