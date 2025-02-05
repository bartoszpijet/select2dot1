import 'package:select2dot1/src/models/item_interface.dart';

/// This is a model class which contains the name of the category and the list of items in the category.
class CategoryItem<T> extends ItemInterface<T> {
  /// The list of items in the category.
  /// If provided that item is CategoryItem<T>.
  final Iterable<ItemInterface<T>> childrens;

  /// Creating an argument constructor of [CategoryItem<T>] class.
  const CategoryItem({
    required super.label,
    required this.childrens,
    super.extraInfo,
    super.icon,
  });

  @override
  int get hashCode => super.hashCode ^ childrens.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryItem<T> &&
          childrens == other.childrens &&
          label == other.label);
}
