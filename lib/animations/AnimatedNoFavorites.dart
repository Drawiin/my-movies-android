import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AnimatedNoFavorites extends StatefulWidget {
  @override
  _AnimatedNoFavoritesState createState() => _AnimatedNoFavoritesState();
}

class _AnimatedNoFavoritesState extends State<AnimatedNoFavorites> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        child: FlareActor(
          "assets/animations/no_favorites.flr",
          fit: BoxFit.contain,
          animation: 'Swing',

        ),
      ),
    );
  }
}
