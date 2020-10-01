import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_movies_app/components/LoadingPlaceholder.dart';
import 'package:my_movies_app/entities/entities.dart';
import 'package:my_movies_app/styles/AppColors.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function(int) remove;
  final Function(Movie) add;
  final bool isFavorite;

  MovieCard(this.movie, this.remove, this.add, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: AppColors.primary,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 1,
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 80, bottom: 80),
                        child: LoadingPlaceholder(),
                      ),
                    ),
                    Container(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image:
                            'https://image.tmdb.org/t/p/w300/${movie.backdropPath}',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: 36,
                            color: AppColors.textOnPrimary,
                          ),
                          onPressed: () => {
                            if (isFavorite) {remove(movie.id)} else {add(movie)}
                          },
                        )),
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
                          child: Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.yellowAccent,
                          ),
                        ),
                        Text(
                          movie.voteAverage.toString(),
                          style: TextStyle(
                              color: AppColors.textOnPrimary, fontSize: 20),
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
