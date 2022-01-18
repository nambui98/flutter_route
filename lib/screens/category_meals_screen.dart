import 'package:flutter/material.dart';
import 'package:flutter_router/models/meal.dart';
import 'package:flutter_router/widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/category-meals";
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryId;
  String? categoryTitle;
  Color? categoryColor;
  List<Meal>? categoryMeals;

  bool _loadingInitDate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadingInitDate) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
      categoryId = routeArgs['id'] as String;
      categoryTitle = routeArgs['title'] as String;
      categoryColor = routeArgs['color'] as Color;
      categoryMeals = widget.availableMeals
          .where((element) => element.categories.contains(categoryId))
          .toList();
      _loadingInitDate = true;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void RemoveItem(String mealId) {
    setState(() {
      widget.availableMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text(categoryTitle!), backgroundColor: categoryColor),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
                meal: categoryMeals![index], RemoveItem: RemoveItem);
          },
          itemCount: categoryMeals?.length,
        ));
  }
}
