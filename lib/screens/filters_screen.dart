import 'package:flutter/material.dart';
import 'package:flutter_router/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";
  final Function saveFilters;
  final Map<String, bool> filters;
  const FiltersScreen(
      {Key? key, required this.saveFilters, required this.filters})
      : super(key: key);
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;
  @override
  initState() {
    _glutenFree = widget.filters['gluten'] as bool;
    _lactoseFree = widget.filters['lactose'] as bool;
    _vegan = widget.filters['vegan'] as bool;
    _vegetarian = widget.filters['vegetarian'] as bool;
    super.initState();
  }

  Widget _buildSwitchListTitle(
      String title, String des, bool currentValue, Function updateValue) {
    return SwitchListTile(
        value: currentValue,
        title: Text(title),
        subtitle: Text(des),
        onChanged: (newValue) => updateValue(newValue));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("filter"),
          actions: [
            IconButton(
                onPressed: () {
                  final selectedFilters = {
                    'gluten': _glutenFree,
                    'lactose': _lactoseFree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian,
                  };
                  widget.saveFilters(selectedFilters);
                },
                icon: Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text('Adjust your meal selection.',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchListTitle(
                    'Gluten-free', 'Only include gluten-free meal', _glutenFree,
                    (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                _buildSwitchListTitle('Lactose-free',
                    'Only include Lactose-free meal', _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                _buildSwitchListTitle(
                    'Vegetarian', 'Only include vegetarian meal', _vegetarian,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                _buildSwitchListTitle(
                    'Vegan', 'Only include vegan meal', _vegan, (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                })
              ],
            ))
          ],
        ));
  }
}
