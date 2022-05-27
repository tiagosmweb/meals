import 'package:flutter/material.dart';
import 'screens/meal_details.dart';
import 'screens/tabs.dart';
import 'screens/categories.dart';
import 'screens/categories_meals.dart';
import 'screens/filters.dart';
import 'utils/app_routes.dart';
import 'models/meal.dart';
import 'models/filters.dart';
import 'data/dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Filters filters = Filters();
  List<Meal> _availableMeals = DUMMY_MEALS;

  void _filterMeals(Filters filters) {
    setState(() {
      this.filters = filters;

      _availableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = filters.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = filters.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = filters.isVegan && !meal.isVegan;
        final filterVegetarian = filters.isVegetarian && !meal.isVegetarian;
        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        fontFamily: 'Raleway',
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
      ),
      // home: CategorieScreen(),
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(),
        AppRoutes.CATEGORIES_MEALS: (ctx) =>
            CategoriesMealsScreen(_availableMeals),
        AppRoutes.MEAL_DETAILS: (ctx) => MealDetailsScreen(),
        AppRoutes.FILTERS: (ctx) => FiltersScreen(filters, _filterMeals),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) {
            return CategorieScreen();
          },
        );
      },
    );
  }
}
