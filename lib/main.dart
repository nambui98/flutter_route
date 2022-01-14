import 'package:flutter/material.dart';
import 'package:flutter_router/screens/category_meals_screen.dart';
import 'package:flutter_router/screens/filters_screen.dart';
import 'package:flutter_router/screens/meal_detail_screen.dart';
import 'package:flutter_router/screens/tabs_creen.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen()
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
