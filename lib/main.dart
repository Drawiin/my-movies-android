import 'package:flutter/material.dart';
import 'file:///C:/Users/vini6/projects/my-movies-android/lib/styles/colors.dart';

import 'screens/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = <Widget>[
    Home(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: MaterialApp(
        theme: ThemeData.dark(),
        title: 'My Movies',
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Filmes populares',
              style: TextStyle(color: AppColors.textOnPrimary),
            ),
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                title: Text('Populares'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: Text('Favoritos'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Buscar'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.textOnPrimary,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
