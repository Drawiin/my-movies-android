import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AnimatedEmptyList extends StatefulWidget {
  @override
  _AnimatedEmptyListState createState() => _AnimatedEmptyListState();
}

class _AnimatedEmptyListState extends State<AnimatedEmptyList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        child: FlareActor(
          "assets/animations/empty_list.flr",
          fit: BoxFit.contain,
          animation: 'loop',

        ),
      ),
    );
  }
}
