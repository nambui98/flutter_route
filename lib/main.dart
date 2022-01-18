import 'package:flutter/material.dart';
import 'package:flutter_router/dummy_data.dart';
import 'package:flutter_router/models/meal.dart';
import 'package:flutter_router/screens/category_meals_screen.dart';
import 'package:flutter_router/screens/filters_screen.dart';
import 'package:flutter_router/screens/meal_detail_screen.dart';
import 'package:flutter_router/screens/tabs_creen.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoritedMeals = [];
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoritedMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex > -1) {
      setState(() {
        _favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoritedMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Router',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        // colorScheme: ColorScheme(secondary: Colors.amber),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "BeVietnamPro",
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            subtitle1: const TextStyle(
                fontSize: 20,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold)),
      ),
      // home: const CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(
            favoritedMeals: _favoritedMeals, toggleFavorite: _toggleFavorite),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
            toggleFavorite: _toggleFavorite, isMealFavorite: _isMealFavorite),
        FiltersScreen.routeName: (ctx) =>
            FiltersScreen(saveFilters: _setFilters, filters: _filters)
      },
      onGenerateRoute: (settings) {
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
