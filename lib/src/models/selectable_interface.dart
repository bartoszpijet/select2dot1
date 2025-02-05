import 'package:select2dot1/src/models/item_interface.dart';

/// This is a model class which contains the name of the item, the value of the item, the extra info of the item, and the avatar of the item.
abstract class SelectableInterface<T> extends ItemInterface<T> {
  /// The value of this item.
  final T? value;

  /// If item is selectable.
  /// Default true.
  final bool enabled;

  /// Function that get Label for this item.
  /// Only one of label or getLabel may be not null.
  /// Either of label or getLabel is required.
  final String Function(T? value)? getLabel;

  /// Data with which this item may be found in search except it's label and/or value.
  final Set<String> metadataSearch;

  final double score;

  @override
  String get finalLabel => label ?? getLabel?.call(value) ?? 'NULL';

  /// Creating an argument constructor of [SelectableInterface] class.
  const SelectableInterface({
    required this.value,

    /// The label of this item.
    /// Only one of label or getLabel may be not null.
    /// Either of label or getLabel is required.
    super.label,
    this.getLabel,
    this.enabled = true,
    super.extraInfo,
    super.icon,
    this.metadataSearch = const {},
  }) : score = 0;

  const SelectableInterface.withScore({
    required this.value,
    super.label,
    this.getLabel,
    this.enabled = true,
    super.extraInfo,
    super.icon,
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
