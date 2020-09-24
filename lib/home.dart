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
  int _currentPage;
  int _totalPages;

  _reload() async {
    final popularMovies = await _moviesRepository.loadMovies(1);
    setState(() {
      _currentPage = 1;
      _totalPages = popularMovies.totalPages;
      _movies.clear();
      _movies.addAll(popularMovies.results);
    });
  }

  _loadNextPage() async {
    if((_currentPage + 1) > _totalPages) return;
    final popularMovies = await _moviesRepository.loadMovies(_currentPage + 1);
    setState(() {
      _totalPages = popularMovies.totalPages;
      _currentPage++;
      _movies.addAll(popularMovies.results);
    });
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
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return _movies.isEmpty
        ? _loadingPlaceholder()
        : ListView.builder(
            itemBuilder: (context, index) {
              if (index == _movies.length) return _loadingPlaceholder();

              if (index == _movies.length - 1) _loadNextPage();

              return ListTile(
                title: Text(_movies[index].title),
              );
            },
            itemCount: _movies.length + 1,
          );
  }
}
