import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:unit_converter/ui/backdrop.dart';
import 'package:unit_converter/data/category2.dart';
import 'package:unit_converter/ui/category_tile.dart';
import 'package:unit_converter/data/unit.dart';
import 'package:unit_converter/ui/unit_converter.dart';

class CategoryRoute extends StatefulWidget {
  const CategoryRoute({Key? key}) : super(key: key);

  @override
  State<CategoryRoute> createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryRoute> {
  Category2? _defaultCategory;
  Category2? _currentCategory;

  final _categories = <Category2>[];

  // region
  static const _icons = <String>[
    'assets/icons/length.png',
    'assets/icons/area.png',
    'assets/icons/volume.png',
    'assets/icons/mass.png',
    'assets/icons/time.png',
    'assets/icons/digital_storage.png',
    'assets/icons/power.png',
    'assets/icons/currency.png',
  ];

  static const _baseColors = <ColorSwatch>[
    ColorSwatch(0xFF6AB7A8, {
      'highlight': Color(0xFF6AB7A8),
      'splash': Color(0xFF0ABC9B),
    }),
    ColorSwatch(0xFFFFD28E, {
      'highlight': Color(0xFFFFD28E),
      'splash': Color(0xFFFFA41C),
    }),
    ColorSwatch(0xFFFFB7DE, {
      'highlight': Color(0xFFFFB7DE),
      'splash': Color(0xFFF94CBF),
    }),
    ColorSwatch(0xFF8899A8, {
      'highlight': Color(0xFF8899A8),
      'splash': Color(0xFFA9CAE8),
    }),
    ColorSwatch(0xFFEAD37E, {
      'highlight': Color(0xFFEAD37E),
      'splash': Color(0xFFFFE070),
    }),
    ColorSwatch(0xFF81A56F, {
      'highlight': Color(0xFF81A56F),
      'splash': Color(0xFF7CC159),
    }),
    ColorSwatch(0xFFD7C0E2, {
      'highlight': Color(0xFFD7C0E2),
      'splash': Color(0xFFCA90E5),
    }),
    ColorSwatch(0xFFCE9A9A, {
      'highlight': Color(0xFFCE9A9A),
      'splash': Color(0xFFF94D56),
      'error': Color(0xFF912D2D),
    }),
  ];

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    // We have static unit conversions located in our assets/data/regular_units.json
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
    }
    _defaultCategory = _categories[0];
  }

  Future<void> _retrieveLocalCategories() async {
    final json = DefaultAssetBundle.of(context).loadString('assets/data/goofy_units.json');
    final data = const JsonDecoder().convert(await json);
    if (data is! Map) {
      throw ('Data retrieved from API is not a Map');
    } else {
      // for (var i = 0; i < data.entries.length; i++) {
      //   var name = data.entries.toList()[i].key;
      //   final List unitList = data.values.toList()[i];
      //   var unitsPerCategory = unitList.map((e) => Unit.fromJson(e)).toList();
      //   var color = _baseColors[i];
      //
      //   var c = Category2(
      //       name: name, color: color, units: unitsPerCategory, iconLocation: Icons.api_sharp);
      //   _categories.add(c);
      // }
      var categoryIndex = 0;
      for (var key in data.keys) {
        final List<Unit> units = data[key].map<Unit>((dynamic data) => Unit.fromJson(data)).toList();

        var category =
        Category2(
            name: key, units: units, color: _baseColors[categoryIndex], iconLocation: _icons[categoryIndex]);
        setState(() {
          if (categoryIndex == 0) {
            _defaultCategory = category;
          }
          _categories.add(category);
        });
        categoryIndex += 1;
      }
    }
  }

  // endregion

  // List<Unit> _retrieveUnitList(String categoryName) {
  //   // return List.generate(10, (int i) {
  //   //   i += 1;
  //   //   return Unit(
  //   //     name: '$categoryName Unit $i',
  //   //     conversion: i.toDouble(),
  //   //   );
  //   // });
  // }

  void _onCategoryTap(Category2 category) {
    setState(() {
      _currentCategory = category;
    });
  }

  Widget _buildCategoryWidgets(Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.portrait) {
      return ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              CategoryTile(category: _categories[index], onTap: _onCategoryTap),
          itemCount: _categories.length);
    } else {
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: _categories.map((e) => CategoryTile(category: e, onTap: _onCategoryTap)).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_categories.isEmpty) {
      return const Center(
        child: SizedBox(
          height: 180.0,
          width: 180.0,
          child: CircularProgressIndicator(),
        ),
      );
    }

    // assert(debugCheckHasMediaQuery(context));
    final listView = Container(
      color: _currentCategory?.color,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 48.0),
      child: _buildCategoryWidgets(MediaQuery
          .of(context)
          .orientation),
    );

    return Backdrop(
      currentCategory: _currentCategory ?? _defaultCategory!,
      frontPanel: _currentCategory == null
          ? UnitConverter(category: _defaultCategory!)
          : UnitConverter(category: _currentCategory!),
      backPanel: listView,
      frontTitle: const Text('Unit Converter'),
      backTitle: const Text('Select a Category'),
    );

    // final appBar = AppBar(
    //     elevation: 0.0,
    //     title: const Text('Unit Converter'),
    //     centerTitle: true,
    //     backgroundColor: _backgroundColor);

    // return Scaffold(
    //   appBar: appBar,
    //   body: listView,
    // );
  }
}
