import 'package:flutter/material.dart';
import 'package:select2dot1/src/models/category_item.dart';
import 'package:select2dot1/src/models/item_interface.dart';
import 'package:select2dot1/src/models/selectable_interface.dart';
import 'package:select2dot1/src/models/selectable_item.dart';
import 'package:select2dot1/src/utils/deep_contains.dart';

/// SelectDataController is a class that will be used to control select data and contains all data.
class SelectDataController<T> extends ChangeNotifier {
  /// All data pass to the package.
  /// It is required.
  Iterable<ItemInterface<T>> data;

  /// This is a boolean to set multi select or single select.
  /// Default is true.
  bool isMultiSelect;

  /// This is initial selected data.
  /// This data will be add to the [selectedList] when the class is created.
  /// If [isMultiSelect] is false, must be null or length <= 1.
  final Iterable<SelectableInterface<T>>? initSelected;

  /// This is a list of [SelectableItem] selected items.
  final Set<SelectableInterface<T>> selectedList = {};

  /// SelectDataController is a class that will be used to control select data.
  /// Use this constructor to create a [SelectDataController] object.
  /// [data] is required.
  /// If [isMultiSelect] is false, [initSelected] must be null or length <= 1.
  SelectDataController({
    required this.data,
    this.isMultiSelect = true,
    this.initSelected,
  }) : assert(
          isMultiSelect || initSelected == null || initSelected.length <= 1,
          'For single select, initSelected must be null or length <= 1',
        ) {
    addGroupSelectChip(initSelected?.where((e) => data.deepContains(e)));
  }

  /// Function to set an SelectDataController to another SelectDataController with the same reference.
  void copyWith(SelectDataController<T> selectDataController) {
    data = selectDataController.data;
    isMultiSelect = selectDataController.isMultiSelect;
    notifyListeners();
  }

  /// Function to clear all selected items.
  void clearSelectedList() {
    selectedList.clear();
    notifyListeners();
  }

  /// Add items from list of [SelectableInterface<T>] to the [selectedList],
  /// when items are in the [data] and not in the [selectedList].
  void addGroupSelectChip(Iterable<SelectableInterface<T>>? singleItemList) {
    if (singleItemList == null || singleItemList.isEmpty) {
      return;
    }

    if (!isMultiSelect) {
      setSingleSelect(singleItemList.single);
    }

    for (var singleItem in singleItemList) {
      addSelectChip(singleItem, false);
    }
    notifyListeners();
  }

  /// Remove items from list of [SelectableInterface<T>] to the [selectedList],
  /// when items are in the [data] and not in the [selectedList].
  void removeGroupSelectChip(Iterable<SelectableInterface<T>>? singleItemList) {
    if (singleItemList == null) {
      return;
    }

    for (var singleItem in singleItemList) {
      removeSelectedChip(singleItem, false);
    }
    notifyListeners();
  }

  /// Add single [SelectableInterface<T>] to the [selectedList],
  /// when items are in the [data] and not in the [selectedList].
  void addSelectChip(
    SelectableInterface<T>? singleItem, [
    bool notify = true,
  ]) {
    if (singleItem == null) {
      return;
    }

    if (!_singleItemContainsInSelected(singleItem)) {
      bool added = selectedList.add(getCategoryFromData(singleItem));
      if (notify && added) notifyListeners();
    }
  }

  /// Remove single [SelectableInterface<T>] from the [selectedList],
  /// when items are in the [data] and not in the [selectedList].
  void removeSelectedChip(
    SelectableInterface<T>? singleItem, [
    bool notify = true,
  ]) {
    if (singleItem == null) {
      return;
    }

    if (_singleItemContainsInSelected(singleItem)) {
      // Its ok.
      // ignore: avoid-ignoring-return-values
      selectedList.remove(singleItem);
      if (notify) notifyListeners();
    }
  }

  /// Set single [SelectableInterface<T>] to the [selectedList],
  /// when items are in the [data] and not in the [selectedList].
  void setSingleSelect(SelectableInterface<T>? singleItem) {
    if (singleItem == null) {
      return;
    }

    selectedList.clear();
    bool added = selectedList.add(getCategoryFromData(singleItem));
    if (added) notifyListeners();
  }

  /// Check if the [SelectableInterface<T>] is in the [selectedList].
  bool _singleItemContainsInSelected(SelectableInterface<T>? singleItem) {
    if (singleItem == null) {
      return false;
    }

    return selectedList.contains(singleItem);
  }

  SelectableInterface<T> getCategoryFromData(
    SelectableInterface<T> patternSingleItem,
  ) {
    SelectableInterface<T>? returnedVal;
    for (ItemInterface<T> item in data.whereType()) {
      returnedVal = deepContains(patternSingleItem, item);
      if (returnedVal != null) break;
    }

    return returnedVal ?? patternSingleItem;
  }

  SelectableInterface<T>? deepContains(
    SelectableInterface<T> search,
    ItemInterface<T> inThis,
  ) {
    if (search == inThis) {
      return search;
    }
    if (inThis is! CategoryItem<T> || inThis.childrens.isEmpty) {
      return null;
    } else {
      SelectableInterface<T>? contain;
      for (ItemInterface<T> inner in inThis.childrens) {
        contain = deepContains(search, inner);
        if (contain != null) break;
      }

      return contain;
    }
  }
}
