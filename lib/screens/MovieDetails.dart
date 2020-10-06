import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_movies_app/components/LoadingPlaceholder.dart';
import 'package:my_movies_app/components/MovieImage.dart';
import 'package:my_movies_app/entities/Movie.dart';
import 'package:my_movies_app/services/ApiClient.dart';
import 'package:my_movies_app/styles/AppColors.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;
  final Function(int) remove;
  final Function(Movie) add;
  final bool isFavorite;

  MovieDetails({
    @required this.movie,
    this.remove,
    this.add,
    this.isFavorite,
  });

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  final apiClient = ApiClient();
  bool _isFavorite;

  void removeFromFavorite() {
    setState(() {
      _isFavorite = false;
    });
    widget.remove(widget.movie.id);
  }

  void addToFavorite() {
    setState(() {
      _isFavorite = true;
    });
    widget.add(widget.movie);
  }

  @override
  void initState() {
    _isFavorite = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 30,
                color: AppColors.textOnPrimary,
              ),
              onPressed: () => {
                if (_isFavorite) {removeFromFavorite()} else {addToFavorite()}
              },
            ),
          ],
          centerTitle: true,
          title: Text('Detalhes'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
            color: AppColors.textOnPrimary,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Hero(
          tag: widget.movie.id,
          child: Card(
            color: AppColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 250,
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 80, bottom: 80),
                          child: LoadingPlaceholder(),
                        ),
                      ),
                      MovieImage(
                        imageUrl:
                            apiClient.resolveImagePath(widget.movie.backdropPath),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: ListTile(
                        title: Text(
                          widget.movie.title,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(widget.movie.releaseDate.split('-')[0]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.star,
                              size: 20,
                              color: Colors.yellowAccent,
                            ),
                          ),
                          Text(
                            widget.movie.voteAverage.toString(),
                            style: TextStyle(
                                color: AppColors.textOnPrimary, fontSize: 20),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(
                      widget.movie.overview,
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
