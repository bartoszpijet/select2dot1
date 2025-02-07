import 'package:select2dot1/src/models/selectable_interface.dart';

/// This is a model class which contains Selectable item.
class SelectableItem<T> extends SelectableInterface<T> {
  /// Creating an argument constructor of [SelectableItem] class.
  const SelectableItem({
    required super.value,
    super.label,
    super.getLabel,
    super.enabled,
    super.metadataSearch,
  });

  SelectableItem._score(SelectableItem<T> item, double score)
      : super.withScore(
          value: item.value,
          getLabel: item.getLabel,
          label: item.label,
          enabled: item.enabled,
          metadataSearch: item.metadataSearch,
          score: score,
        );

  @override
  SelectableInterface<T> copyWithScore(double score) =>
      SelectableItem._score(this, score);
}
