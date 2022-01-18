import 'package:flutter/material.dart';
import 'package:flutter_router/dummy_data.dart';
import 'package:flutter_router/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = "/meal-detail";
  final Function toggleFavorite;
  final Function isMealFavorite;
  const MealDetailScreen(
      {Key? key, required this.toggleFavorite, required this.isMealFavorite})
      : super(key: key);
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 150,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: isMealFavorite(mealId)
            ? Icon(Icons.delete)
            : Icon(
                Icons.star,
                // color: Colors.red[400],
              ),
        onPressed: () => toggleFavorite(mealId),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, "Ingredients"),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      meal.ingredients[index],
                    ),
                  ),
                ),
                itemCount: meal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, "Steps"),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${(index + 1)}'),
                    ),
                    title: Text(
                      meal.steps[index],
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Divider()
                ]),
                itemCount: meal.steps.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
