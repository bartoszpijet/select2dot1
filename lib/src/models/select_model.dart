import 'package:flutter/material.dart';

/// This is a model class which contains the name of the item, the value of the item, the extra info of the item, and the avatar of the item.
abstract class SelectModel<T> {
  /// If item is enabled.
  /// Default true.
  final bool enabled;

  /// The list of items in the category.
  /// If provided .
  final List<SelectModel<T>> itemList;

  /// If item is category.
  /// Default false.
  final bool isCategory;

  /// The name of the single item.
  /// It is required.
  final String itemName;

  /// The value of the single item.
  /// It is optional
  /// [value] preffer set to avoid duplicate items when two objects [itemName] is the same.
  final T? value;

  /// The extra info of the single item.
  /// It is optional.
  final String? extraInfoSingleItem;

  /// The avatar of the single item.
  /// It is optional.
  final Widget? avatarSingleItem;

  @override
  int get hashCode => itemName.hashCode ^ value.hashCode;

  /// Creating an argument constructor of [SelectModel] class.
  const SelectModel({
    required this.itemName,
    this.value,
    this.extraInfoSingleItem,
    this.avatarSingleItem,
    this.itemList = const [],
    this.isCategory = false,
    this.enabled = true,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectModel &&
          runtimeType == other.runtimeType &&
          itemName == other.itemName &&
          value == other.value;
}
