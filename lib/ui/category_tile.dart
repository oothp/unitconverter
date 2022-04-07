import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unit_converter/data/category2.dart';
import 'package:unit_converter/ui/unit_converter.dart';

const _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

/// A [CategoryTile] to display a [Category].
class CategoryTile extends StatelessWidget {
  final Category2 category;
  final ValueChanged<Category2> onTap;

  const CategoryTile({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  /// Navigates to the [UnitConverter].
  void _navigateToConverter(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute<void>(
    //   builder: (BuildContext context) {
    //     return Scaffold(
    //       // appBar: AppBar(
    //       //   // elevation: 1.0,
    //       //   title: Text(
    //       //     category.name,
    //       //     // style: Theme.of(context).textTheme.headline4,
    //       //   ),
    //       //   centerTitle: true,
    //       //   // backgroundColor: category.color,
    //       // ),
    //       body: UnitConverter(category: category),
    //       // This prevents the attempt to resize the screen when the keyboard
    //       // is opened
    //       resizeToAvoidBottomInset: false,
    //     );
    //   },
    // ));
  }

  /// Builds a custom widget that shows [Category] information.
  ///
  /// This information includes the icon, name, and color for the [Category].
  @override
  // This `context` parameter describes the location of this widget in the
  // widget tree. It can be used for obtaining Theme data from the nearest
  // Theme ancestor in the tree. Below, we obtain the display1 text theme.
  // See https://api.flutter.dev/flutter/material/Theme-class.html
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: category.color['highlight'],
          splashColor: category.color['splash'],
          // We can use either the () => function() or the () { function(); }
          // syntax.
          // TODO: This should call the onTap() passed into the constructor
          onTap: () =>  onTap(category), //_navigateToConverter(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // There are two ways to denote a list: `[]` and `List()`.
              // Prefer to use the literal syntax, i.e. `[]`, instead of `List()`.
              // You can add the type argument if you'd like, i.e. <Widget>[].
              // See https://www.dartlang.org/guides/language/effective-dart/usage#do-use-collection-literals-when-possible
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(category.iconLocation),
                ),
                Center(
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}