import 'package:flutter/material.dart';
import 'package:my_movies_app/components/LoadingPlaceholder.dart';
import 'package:my_movies_app/components/MovieCard.dart';
import 'package:my_movies_app/entities/Movie.dart';
import 'package:my_movies_app/entities/PagedMoviesRequest.dart';
import 'package:my_movies_app/services/ApiClient.dart';
import 'package:my_movies_app/styles/AppColors.dart';

class MoviesSearchDelegate extends SearchDelegate<String> {
  final apiClient = ApiClient();
  var previousRequest = PagedMoviesRequest();

  MoviesSearchDelegate() : super(searchFieldLabel: 'Buscar filmes');

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.close,
          color: AppColors.textOnPrimary,
        ),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        color: AppColors.textOnPrimary,
        progress: transitionAnimation,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final response = apiClient.searchMovies(1, query);

    return FutureBuilder<PagedMoviesRequest>(
      future: response,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return buildSearchResults(snapshot.data);
        } else {
          return LoadingPlaceholder();
        }
      },
    );
  }

  String selectedResult;

  @override
  Widget buildSuggestions(BuildContext context) {
    Future<PagedMoviesRequest> response;
    if (query.isEmpty) {
      response = apiClient.getPopularMovies(1);
    } else {
      response = apiClient.searchMovies(1, query);
    }

    return FutureBuilder<PagedMoviesRequest>(
      future: response,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          previousRequest = snapshot.data;
        } else if (snapshot.hasError) {
          return Text('oops');
        }
        return buildSearchSuggestions();
      },
    );
  }

  Widget buildSearchSuggestions() {
    final movies = previousRequest?.results;
    return ListView.builder(
      itemBuilder: (context, index) {
        final hasQuery =
            movies[index].title.toLowerCase().startsWith(query.toLowerCase());
        return ListTile(
            onTap: () {
              query = movies[index].title;
              showResults(context);
            },
            title: RichText(
              text: TextSpan(
                  text: hasQuery
                      ? movies[index].title.substring(0, query.length)
                      : '',
                  style: TextStyle(fontWeight: FontWeight.w900),
                  children: [
                    TextSpan(
                      text: hasQuery
                          ? movies[index].title.substring(query.length)
                          : movies[index].title,
                      style: TextStyle(fontWeight: FontWeight.w200),
                    )
                  ]),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.launch,
                color: ThemeData.dark().disabledColor,
              ),
              onPressed: () {
                query = movies[index].title;
              },
            ),
            leading: Icon(
              Icons.search,
              color: ThemeData.dark().disabledColor,
            ));
      },
      itemCount: movies.length,
    );
  }

  Widget itemBuilder(Movie movie) {
    return MovieCard(movie, (int) {}, (movie) {}, false);
  }

  Widget buildSearchResults(PagedMoviesRequest result) {
    final movies = result.results;
    return ListView.builder(
      itemBuilder: (context, index) => itemBuilder(movies[index]),
      itemCount: movies.length,
    );
  }
}
