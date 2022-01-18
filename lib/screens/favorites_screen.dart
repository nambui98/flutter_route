import 'package:flutter/material.dart';
import 'package:flutter_router/models/meal.dart';
import 'package:flutter_router/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoritedMeals;
  final Function toggleFavorite;
  const FavoritesScreen(
      {Key? key, required this.favoritedMeals, required this.toggleFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoritedMeals.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    }
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return MealItem(
            meal: favoritedMeals[index],
            RemoveItem: () => toggleFavorite(favoritedMeals[index].id));
      },
      itemCount: favoritedMeals.length,
    );
  }
}
