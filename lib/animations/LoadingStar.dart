import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoadingStar extends StatefulWidget {
  @override
  _LoadingStarState createState() => _LoadingStarState();
}

class _LoadingStarState extends State<LoadingStar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      child: FlareActor(
        "assets/animations/loading_star.flr",
        fit: BoxFit.contain,
        animation: 'loading',

      ),
    );
  }
}