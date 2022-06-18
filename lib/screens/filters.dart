import 'package:flutter/material.dart';
import '../components/main_drawer.dart';
import '../models/filters.dart';

class FiltersScreen extends StatefulWidget {
  final Filters filters;
  final Function(Filters) onFiltersChanged;

  const FiltersScreen(this.filters, this.onFiltersChanged);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late Filters filters;

  @override
  void initState() {
    super.initState();
    filters = widget.filters;
  }

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onFiltersChanged(filters);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtros'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _createSwitch(
                  'Sem Glutén',
                  'Lista refeições sem glutén',
                  filters.isGlutenFree,
                  (value) => setState(() => filters.isGlutenFree = value),
                ),
                _createSwitch(
                  'Sem Lactose',
                  'Lista refeições sem Lactose',
                  filters.isLactoseFree,
                  (value) => setState(() => filters.isLactoseFree = value),
                ),
                _createSwitch(
                  'Vegana',
                  'Lista  refeições Vegana',
                  filters.isVegan,
                  (value) => setState(() => filters.isVegan = value),
                ),
                _createSwitch(
                  'Vegetariana',
                  'Lista refeições Vegetarianas',
                  filters.isVegetarian,
                  (value) => setState(() => filters.isVegetarian = value),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
