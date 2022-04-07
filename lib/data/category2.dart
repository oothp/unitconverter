import 'package:flutter/material.dart';
import 'package:unit_converter/data/unit.dart';

/// A [Category] keeps track of a list of [Unit]s.
class Category2 {
  final String name;
  final ColorSwatch color;
  final List<Unit> units;
  final String iconLocation;

  /// Information about a [Category].
  ///
  /// A [Category] saves the name of the Category (e.g. 'Length'), a list of its
  /// its color for the UI, units for conversions (e.g. 'Millimeter', 'Meter'),
  /// and the icon that represents it (e.g. a ruler).
  const Category2({
    required this.name,
    required this.color,
    required this.units,
    required this.iconLocation,
  });
}