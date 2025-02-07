import 'package:select2dot1/src/utils/event_args.dart';

/// This is a model class which contains the name of the item, the value of the item, the extra info of the item, and the avatar of the item.
abstract class ItemInterface<T> {
  /// The stringified label of this item, required as fallback for [getLabel].
  final String label;

  /// Function that get Label for this item.
  final LabelBuilder<T>? getLabel;

  /// Data with which this item may be found in search except it's label and/or value.
  final Set<String> metadataSearch;

  final double score;

  /// Creating an argument constructor of [ItemInterface<T>] class.
  const ItemInterface({
    this.label = '',
    this.getLabel,
    this.metadataSearch = const {},
  }) : score = 0;

  const ItemInterface.withScore({
    this.label = '',
    this.getLabel,
    this.metadataSearch = const {},
    this.score = 0,
  });

  ItemInterface<T> copyWithScore(double score);

  @override
  int get hashCode => label.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemInterface<T> &&
          runtimeType == other.runtimeType &&
          label == other.label;
}
