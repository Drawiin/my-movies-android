import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedFavoriteButton extends StatefulWidget {
  final Function onPressed;
  final bool isFavorite;

  AnimatedFavoriteButton({@required this.onPressed, @required this.isFavorite});

  @override
  _AnimatedFavoriteButtonState createState() => _AnimatedFavoriteButtonState();
}

class _AnimatedFavoriteButtonState extends State<AnimatedFavoriteButton> {
  String _animationName;
  bool _isFavorite;

  _updateAnim() {
    setState(() {
      _isFavorite = !_isFavorite;
      _animationName = _isFavorite ? 'Favorite' : 'Unfavorite';
    });
  }

  @override
  void initState() {
    _isFavorite = widget.isFavorite;
    _animationName = _isFavorite ? 'Favorite_idle' : 'Unfavorite_idle';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onPressed();
          _updateAnim();
        },
        child: Container(
          width: 70,
          height: 70,
          child: FlareActor(
            "assets/animations/favorite.flr",
            animation: _animationName,
          ),
        ));
  }
}
