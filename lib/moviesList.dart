import 'package:flutter/material.dart';
import 'package:my_movies_app/entities.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> movies;

  MoviesList(this.movies);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8),
      children: movies
          .map((movie) => Container(
                height: 60,
                child: Center(
                  child: ListTile(
                    title: Text(movie.title),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
