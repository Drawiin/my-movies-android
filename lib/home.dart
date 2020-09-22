import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final List movies;

  Home({@required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Hey this is my home",
        style: TextStyle(fontSize: 30, color: Colors.blueGrey),
      ),
    );
  }
}
