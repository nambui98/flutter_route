import 'package:flutter/material.dart';
import 'package:flutter_router/models/meal.dart';
import 'package:flutter_router/screens/categories_screen.dart';
import 'package:flutter_router/screens/favorites_screen.dart';
import 'package:flutter_router/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoritedMeals;
  final Function toggleFavorite;
  const TabsScreen(
      {Key? key, required this.favoritedMeals, required this.toggleFavorite})
      : super(key: key);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> _page = [];
  int _selectedPageIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    _page = [
      {'page': CategoriesScreen(), 'title': "Categories"},
      {
        'page': FavoritesScreen(
            favoritedMeals: widget.favoritedMeals,
            toggleFavorite: widget.toggleFavorite),
        'title': "Your Favorites"
      }
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_page[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _page[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: 'Categories'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              label: 'Favorites'),
        ],
      ),
    );
  }
}
