import 'package:flutter/material.dart';
import 'package:unit_converter/category_route.dart';

void main() {
  runApp(const UnitConverterApp());
}

/// This widget is the root of our application.
///
/// The first screen we see is a list [Categories].
class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(
        appBarTheme:
            // foregroundColor:  is also appbar text
            const AppBarTheme(iconTheme: IconThemeData(color: Colors.black54)
                // titleTextStyle: TextStyle(
                //   fontFamily: 'Game-of-squids',
                //   color: Colors.black54,
                //   fontSize: 20.0,
                // ),
                ),
        // appbar text color universally.
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.grey[600],
              fontFamily: 'Raleway',
            ),
        primaryColor: Colors.grey[500],
        textSelectionTheme: TextSelectionThemeData(selectionHandleColor: Colors.green[500]),
      ),
      home: const CategoryRoute(),
    );
  }
}
