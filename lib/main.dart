import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: MaterialApp(
        title: 'My Movies',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Popular'),
          ),
          body: Home(),
        ),
      ),
    );
  }
}
