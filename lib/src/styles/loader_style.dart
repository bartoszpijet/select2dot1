import 'package:flutter/material.dart';

class LoaderStyle {
  /// The padding of the loading data overlay.
  /// Default value is [EdgeInsets.all(8.0)].
  final EdgeInsetsGeometry padding;

  /// Loader alignment.
  final AlignmentGeometry alignment;

  final double? widthFactor;
  final double? heightFactor;

  const LoaderStyle({
    this.padding = const EdgeInsets.all(8.0),
    this.alignment = Alignment.center,
    this.widthFactor,
    this.heightFactor = 1,
  });
}
