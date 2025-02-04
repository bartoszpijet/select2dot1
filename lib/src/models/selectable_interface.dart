import 'package:flutter/material.dart';

/// This is a model class which contains the name of the item, the value of the item, the extra info of the item, and the avatar of the item.
abstract class SelectableInterface<T> {
  /// The value of this item.
  final T? value;

  /// If item is selectable.
  /// Default true.
  final bool enabled;

  /// The label of this item.
  /// Only one of label or getLabel may be not null.
  /// Either of label or getLabel is required.
  final String? label;

  /// Function that get Label for this item.
  /// Only one of label or getLabel may be not null.
  /// Either of label or getLabel is required.
  final String Function(T? value)? getLabel;

  /// The extra info of this item.
  /// It is optional.
  final String? extraInfo;

  /// The icon of this item.
  /// It is optional.
  final Widget? icon;

  /// Data with which this item may be found in search except it's label and/or value.
  final Set<String> metadataSearch;

  final double score;

  String get finalLabel => label ?? getLabel?.call(value) ?? 'NULL';

  /// Creating an argument constructor of [SelectableInterface] class.
  const SelectableInterface({
    required this.value,
    this.label,
    this.getLabel,
    this.enabled = true,
    this.extraInfo,
    this.icon,
    this.metadataSearch = const {},
  }) : score = 0;

  const SelectableInterface.withScore({
    required this.value,
    this.label,
    this.getLabel,
    this.enabled = true,
    this.extraInfo,
    this.icon,
    this.metadataSearch = const {},
    this.score = 0,
  });

  SelectableInterface<T> copyWithScore(double score);

  @override
  int get hashCode => finalLabel.hashCode ^ value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectableInterface &&
          runtimeType == other.runtimeType &&
          finalLabel == other.finalLabel &&
          extraInfo == other.extraInfo &&
          value == other.value;
}
