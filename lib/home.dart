import 'package:flutter/material.dart';
import 'package:my_movies_app/repository.dart';

import 'entities.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _moviesRepository = MoviesRepository();
  final _movies = <Movie>[];
  var _currentPage = 1;

  _loadNextPage() async {
    final popularMovies =
        await _moviesRepository.fetchPopularMovies(_currentPage);
    _movies.addAll(popularMovies.results);
  }

  Widget _loadingPlaceholder() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return _movies.isEmpty
        ? _loadingPlaceholder()
        : ListView.builder(
            itemBuilder: (context, index) =>
                ListTile(title: Text(_movies[index].title)),
            itemCount: _movies.length,
          );
  }
}
