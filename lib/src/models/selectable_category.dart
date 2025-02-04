import 'package:select2dot1/src/models/selectable_interface.dart';

/// This is a model class which contains the name of the category and the list of items in the category.
class SelectableCategory<T> extends SelectableInterface<T> {
  /// The list of items in the category.
  /// If provided that item is CategoryItem.
  final List<SelectableInterface<T>> childrens;

  /// Creating an argument constructor of [SelectableCategory] class.
  const SelectableCategory({
    required super.value,
    super.getLabel,
    super.label,
    required this.childrens,
    super.extraInfo,
    super.icon,
    super.enabled,
    super.metadataSearch,
  });

  SelectableCategory._score(
    SelectableCategory<T> item,
    double score, [
    List<SelectableInterface<T>>? childrens,
  ])  : childrens = childrens ?? item.childrens,
        super.withScore(
          value: item.value,
          getLabel: item.getLabel,
          label: item.label,
          extraInfo: item.extraInfo,
          icon: item.icon,
          enabled: item.enabled,
          metadataSearch: item.metadataSearch,
          score: score,
        );

  @override
  SelectableInterface<T> copyWithScore(double score) =>
      SelectableCategory._score(this, score);

  SelectableInterface<T> copyWithScoreAndList(
    double score,
    List<SelectableInterface<T>> childrens,
  ) =>
      SelectableCategory._score(this, score, childrens);

  @override
  int get hashCode => super.hashCode ^ childrens.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SelectableCategory &&
          value == other.value &&
          childrens == other.childrens &&
          finalLabel == other.finalLabel);
}
