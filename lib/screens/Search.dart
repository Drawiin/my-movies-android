import 'package:flutter/material.dart';
import 'package:my_movies_app/screens/Home.dart';
import 'package:my_movies_app/styles/AppColors.dart';
import 'package:my_movies_app/utils/MoviesSearchDelegate.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: AppColors.textOnPrimary,
            ),
            onPressed: () {
              showSearch(context: context, delegate: MoviesSearchDelegate());
            },
          )
        ],
        centerTitle: true,
        title: Text('Buscar Filmes'),
      ),
      body: Home(),
    );
  }
}
