import 'package:flutter/material.dart';
import 'package:my_movies_app/components/LoadingPlaceholder.dart';

class MoviesList extends StatelessWidget {
  final Widget placeHolder;

  const MoviesList({
    this.placeHolder = const LoadingPlaceholder(),
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
