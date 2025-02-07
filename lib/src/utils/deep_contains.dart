import 'package:select2dot1/src/models/category_item.dart';
import 'package:select2dot1/src/models/item_interface.dart';

extension DeepContains<T> on Iterable<ItemInterface<T>> {
  bool deepContains(ItemInterface<T> search) {
    if (contains(search)) {
      return true;
    }
    for (ItemInterface<T> item in this) {
      if (item is! CategoryItem<T> || item.childrens.isEmpty) {
        return false;
      } else {
        return deepContains(item);
      }
    }

    return false;
  }
}
