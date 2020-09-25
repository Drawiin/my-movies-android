import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_movies_app/colors.dart';
import 'package:my_movies_app/entities.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: AppColors.secondary,
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
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.textOnPrimary),
                        ),
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
                            Icons.favorite_border,
                            size: 36,
                            color: AppColors.textOnSecondary,
                          ),
                          onPressed: () => {},
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        movie.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.star,
                            size: 18,
                            color: Colors.yellowAccent,
                          ),
                        ),
                        Text(
                          movie.voteAverage.toString(),
                          style: TextStyle(color: AppColors.textOnSecondary),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
