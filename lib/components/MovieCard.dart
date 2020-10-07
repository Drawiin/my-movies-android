import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_movies_app/animations/AnimatedFavoriteButtom.dart';
import 'package:my_movies_app/animations/AnimatedStar.dart';
import 'package:my_movies_app/animations/AnimatedStyleText.dart';
import 'package:my_movies_app/components/LoadingPlaceholder.dart';
import 'package:my_movies_app/entities/Movie.dart';
import 'package:my_movies_app/screens/MovieDetails.dart';
import 'package:my_movies_app/styles/AppColors.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function(int) remove;
  final Function(Movie) add;
  final bool isFavorite;

  MovieCard(this.movie, this.remove, this.add, this.isFavorite);

  void goToDetails(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MovieDetails(
                  movie: movie,
                  add: add,
                  isFavorite: isFavorite,
                  remove: remove,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToDetails(context),
      child: Hero(
        tag: movie.id,
        child: Card(
          color: AppColors.primary,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 1,
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
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image:
                          'https://image.tmdb.org/t/p/w300/${movie.backdropPath}',
                      fit: BoxFit.fitHeight,
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: AnimatedFavoriteButton(
                            isFavorite: isFavorite,
                            onPressed: () => {
                                  if (isFavorite)
                                    {remove(movie.id)}
                                  else
                                    {add(movie)}
                                })
                        // IconButton(
                        //   icon: Icon(
                        //     isFavorite ? Icons.favorite : Icons.favorite_border,
                        //     size: 36,
                        //     color: AppColors.textOnPrimary,
                        //   ),
                        //   onPressed: () => {
                        //     if (isFavorite) {remove(movie.id)} else {add(movie)}
                        //   },
                        // )
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
                        movie.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(movie.releaseDate.split('-')[0]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: AnimatedStar(),
                        ),
                        AnimatedStyleText(
                          movie.voteAverage.toString(),
                          initialStyle: TextStyle(
                              color: ThemeData.dark().disabledColor,
                              fontSize: 0,
                              fontWeight: FontWeight.w100),
                          finalStyle: TextStyle(
                              color: AppColors.textOnPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
