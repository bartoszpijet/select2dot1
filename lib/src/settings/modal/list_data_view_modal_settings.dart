import 'package:flutter/material.dart';

/// This is a class which contains all the settings of the list data view in modal mode.
class ListDataViewModalSettings {
  /// The margin of the list data view.
  /// Default value is [null].
  final EdgeInsetsGeometry? margin;

  /// The padding of the list data view.
  /// Default value is [null].
  final EdgeInsetsGeometry? padding;

  /// Minimum duration of loading data.
  /// Default value is [500 milliseconds].
  final Duration minLoadDuration;

  /// If non-null, forces the children to have the given extent in the scroll direction.
  final double? itemExtents;

  /// Creating an argument constructor of [ListDataViewModalSettings] class.
  const ListDataViewModalSettings({
    this.margin,
    this.padding,
    this.minLoadDuration = const Duration(milliseconds: 500),
    this.itemExtents,
  });
}
