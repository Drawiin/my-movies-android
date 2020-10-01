import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final List<String> list = List.generate(10, (index) => 'list $index');

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
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: MovieSearch(examples: widget.list));
            },
          )
        ],
        centerTitle: true,
        title: Text('Buscar Filmes'),
      ),
      body: ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(widget.list[index]),
        ),
      ),
    );
  }
}

class MovieSearch extends SearchDelegate<String> {
  final List<String> examples;

  MovieSearch({this.examples}) : super(searchFieldLabel: 'Buscar filmes');

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Heyyyy'),
    );
  }

  String selectedResult;

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [];
    List<String> recentList = [];
    query.isEmpty
        ? suggestions = recentList
        : suggestions
            .addAll(examples.where((element) => element.contains(query)));
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestions[index]),
        onTap: () {
          selectedResult = suggestions[index];
          showResults(context);
        },
      ),
      itemCount: suggestions.length,
    );
  }
}
