import 'package:select2dot1/src/models/select_model.dart';

/// This is a model class which contains the name of the item, the value of the item, the extra info of the item, and the avatar of the item.
class ItemModel<T> extends SelectModel<T> {
  @override
  int get hashCode => itemName.hashCode ^ value.hashCode;

  /// Creating an argument constructor of [ItemModel] class.
  const ItemModel({
    required super.itemName,
    required super.value,
    super.extraInfoSingleItem,
    super.avatarSingleItem,
    super.enabled,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SelectModel &&
            itemName == other.itemName &&
            value == other.value);
  }
}
