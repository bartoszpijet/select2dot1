import 'package:select2dot1/src/models/item_interface.dart';

/// This is a model class which contains the name of the category and the list of items in the category.
class CategoryItem<T> extends ItemInterface<T> {
  /// The list of items in the category.
  /// If provided that item is CategoryItem<T>.
  final Iterable<ItemInterface<T>> childrens;

  /// If true and select is multiuselect this Item will be clickable. After click all children will be added to selected list.
  final bool addAllChildren;

  /// Creating an argument constructor of [CategoryItem<T>] class.
  const CategoryItem({
    super.label,
    super.getLabel,
    required this.childrens,
    this.addAllChildren = false,
  });

  CategoryItem._score(
    CategoryItem<T> item,
    double score, [
    Iterable<ItemInterface<T>>? childrens,
  ])  : childrens = childrens ?? item.childrens,
        addAllChildren = item.addAllChildren,
        super.withScore(
          getLabel: item.getLabel,
          label: item.label,
          metadataSearch: item.metadataSearch,
          score: score,
        );

  @override
  ItemInterface<T> copyWithScore(double score) =>
      CategoryItem._score(this, score);

  ItemInterface<T> copyWithScoreAndList(
    double score,
    Iterable<ItemInterface<T>> childrens,
  ) =>
      CategoryItem._score(this, score, childrens);

  @override
  int get hashCode => super.hashCode ^ childrens.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryItem<T> &&
          childrens == other.childrens &&
          label == other.label);
}
