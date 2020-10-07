import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AnimatedStar extends StatefulWidget {
  @override
  _AnimatedStarState createState() => _AnimatedStarState();
}

class _AnimatedStarState extends State<AnimatedStar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      child: FlareActor(
        "assets/animations/star_spinner.flr",
        fit: BoxFit.contain,
        animation: 'rotate',

      ),
    );
  }
}
