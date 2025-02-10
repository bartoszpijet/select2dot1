import 'package:select2dot1/src/models/item_interface.dart';

/// This is a model class which contains the name of the item, the value of the item, the extra info of the item, and the avatar of the item.
abstract class SelectableInterface<T> extends ItemInterface<T> {
  /// The value of this item.
  final T? value;

  /// If item is selectable.
  /// Default true.
  final bool enabled;

  /// Creating an argument constructor of [SelectableInterface] class.
  const SelectableInterface({
    required this.value,

    /// The label of this item.
    /// Only one of label or getLabel may be not null.
    /// Either of label or getLabel is required.
    super.label,
    super.getLabel,
    this.enabled = true,
    super.metadataSearch = const {},
  });

  const SelectableInterface.withScore({
    required this.value,
    super.label,
    super.getLabel,
    this.enabled = true,
    super.metadataSearch = const {},
    double score = 0,
  }) : super.withScore(score: score);

  @override
  int get hashCode => label.hashCode ^ value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectableInterface<T> &&
          label == other.label &&
          value == other.value &&
          enabled == other.enabled;
}
