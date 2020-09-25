import 'package:flutter/material.dart';
import 'package:my_movies_app/colors.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: MaterialApp(
        theme: ThemeData.dark(),
        title: 'My Movies',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: Text(
              'Popular',
              style: TextStyle(color: AppColors.textOnPrimary),
            ),
          ),
          body: Home(),
        ),
      ),
    );
  }
}
