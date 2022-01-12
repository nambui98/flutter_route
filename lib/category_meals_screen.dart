import 'package:flutter/material.dart';
import './dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = "/category-meals";
  // final String categoryId;
  // final String categoryTitle;
  // final Color categoryColor;
  // const CategoryMealsScreen(
  //     {Key? key,
  //     required this.categoryId,
  //     required this.categoryTitle,
  //     required this.categoryColor})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    final String categoryId = routeArgs['id'] as String;
    final String categoryTitle = routeArgs['title'] as String;
    final Color categoryColor = routeArgs['color'] as Color;
    final categoryMeals = DUMMY_MEALS
        .where((element) => element.categories.contains(categoryId))
        .toList();
    return Scaffold(
        appBar:
            AppBar(title: Text(categoryTitle), backgroundColor: categoryColor),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return Text(categoryMeals[index].title);
          },
          itemCount: categoryMeals.length,
        ));
  }
}
