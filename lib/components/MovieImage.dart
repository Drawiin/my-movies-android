import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieImage extends StatelessWidget {
  final String imageUrl;

  MovieImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: imageUrl,
      fit: BoxFit.fitHeight,
    );
  }
}
