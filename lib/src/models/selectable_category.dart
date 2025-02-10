import 'package:select2dot1/src/models/category_item.dart';
import 'package:select2dot1/src/models/item_interface.dart';
import 'package:select2dot1/src/models/selectable_interface.dart';

/// This is a model class which contains the name of the category and the list of items in the category.
class SelectableCategory<T> extends SelectableInterface<T>
    implements CategoryItem<T> {
  /// The list of items in the category.
  /// If provided that item is CategoryItem<T>.
  @override
  final Iterable<ItemInterface<T>> childrens;

  /// If true and select is multiuselect this Item will be clickable. After click all children will be added to selected list.
  @override
  final bool addAllChildren;

  /// Creating an argument constructor of [SelectableCategory] class.
  const SelectableCategory({
    required super.value,
    super.getLabel,
    super.label,
    required this.childrens,
    this.addAllChildren = false,
    super.enabled,
    super.metadataSearch,
  });

  SelectableCategory._score(
    SelectableCategory<T> item,
    double score, [
    Iterable<ItemInterface<T>>? childrens,
  ])  : childrens = childrens ?? item.childrens,
        addAllChildren = item.addAllChildren,
        super.withScore(
          value: item.value,
          getLabel: item.getLabel,
          label: item.label,
          enabled: item.enabled,
          metadataSearch: item.metadataSearch,
          score: score,
        );

  @override
  ItemInterface<T> copyWithScore(double score) =>
      SelectableCategory._score(this, score);

  @override
  ItemInterface<T> copyWithScoreAndList(
    double score,
    Iterable<ItemInterface<T>> childrens,
  ) =>
      SelectableCategory._score(this, score, childrens);
}
