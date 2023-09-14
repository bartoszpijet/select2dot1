import 'package:select2dot1/src/models/select_model.dart';

/// This is a model class which contains the name of the category and the list of items in the category.
class CategoryModel<T> extends SelectModel<T> {
  @override
  int get hashCode => itemName.hashCode ^ itemList.hashCode;

  /// Creating an argument constructor of [CategoryModel] class.
  const CategoryModel({
    required super.itemName,
    required super.itemList,
    super.value,
    super.extraInfoSingleItem,
    super.avatarSingleItem,
    super.enabled,
  }) : super(isCategory: true);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SelectModel &&
          itemName == other.itemName &&
          value == other.value);
}
