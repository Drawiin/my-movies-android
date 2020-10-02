import 'package:flutter/material.dart';
import 'package:my_movies_app/screens/Favorites.dart';
import 'package:my_movies_app/screens/Search.dart';

import 'file:///C:/Users/vini6/projects/my-movies-android/lib/styles/AppColors.dart';

import 'screens/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: [Home(), Favorites(), Search()],
    );
  }

  List<BottomNavigationBarItem> buildBottomNavigationItens() {
    return [
      BottomNavigationBarItem(
          icon: Icon(Icons.local_movies), title: Text('Populares')),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite), title: Text('Favoritos')),
      BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Buscar'))
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'My Movies',
      home: SafeArea(
        child: Scaffold(
          body: buildPageView(),
          bottomNavigationBar: BottomNavigationBar(
            items: buildBottomNavigationItens(),
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.textOnPrimary,
            onTap: _onItemTapped,
            elevation: 8,
          ),
        ),
      ),
    );
  }
}
