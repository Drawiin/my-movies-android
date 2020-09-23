import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_movies_app/moviesList.dart';

import 'entities.dart';

const API_KEY = 'ef60f290754b298f307a2b64735fddfb';
const LANGUAGE = 'pt-BR';

Future<PopularMovies> fetchPopularMovies(int page) async {
  final response = await http.get(
      'https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY&language=$LANGUAGE&page=$page');
  return PopularMovies.fromJson(jsonDecode(response.body));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<PopularMovies> popularMovies;
  var currentPage = 1;
  final movies = List<Movie>();

  @override
  void initState() {
    super.initState();
    popularMovies = fetchPopularMovies(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<PopularMovies>(
      future: popularMovies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MoviesList(snapshot.data.results);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    ));
  }
}
