import 'package:flutter/material.dart';
import 'package:my_movies_app/entities.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> movies;

  MoviesList(this.movies);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(movies[index].title),
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
