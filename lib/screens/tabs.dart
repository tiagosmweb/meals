import 'package:flutter/material.dart';
import 'package:meals/screens/favorite.dart';
import 'categories.dart';
import '../components/main_drawer.dart';
import '../models/meal.dart';
import 'categories_meals.dart';

class TabsScreen extends StatefulWidget {
  List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  final List<String> _titles = [
    'Lista de Categorias',
    'Meus Favoritos',
  ];

  late List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      CategorieScreen(),
      FavoriteScreen(widget.favoriteMeals),
    ];
  }

  _selectedScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titles[_selectedScreenIndex]),
        ),
        drawer: MainDrawer(),
        body: _screens[_selectedScreenIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedScreen,
          backgroundColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          currentIndex: _selectedScreenIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categoria',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favoritos',
            ),
          ],
        ),
      ),
    );
  }
}
