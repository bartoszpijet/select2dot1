import 'package:flutter/material.dart';

/// This is a model class which contains the name of the item, the value of the item, the extra info of the item, and the avatar of the item.
abstract class ItemInterface<T> {
  /// The label of this item.
  final String? label;

  /// The extra info of this item.
  /// It is optional.
  final String? extraInfo;

  /// The icon of this item.
  /// It is optional.
  final Widget? icon;

  /// Creating an argument constructor of [ItemInterface<T>] class.
  const ItemInterface({
    required this.label,
    this.extraInfo,
    this.icon,
  });

  String get finalLabel => label ?? 'NULL';

  @override
  int get hashCode => label.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemInterface<T> &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          extraInfo == other.extraInfo;
}
