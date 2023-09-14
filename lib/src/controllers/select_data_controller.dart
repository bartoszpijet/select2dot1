import 'package:flutter/material.dart';
import 'package:select2dot1/src/models/item_model.dart';
import 'package:select2dot1/src/models/select_model.dart';

/// SelectDataController is a class that will be used to control select data and contains all data.
class SelectDataController<T> extends ChangeNotifier {
  /// All data pass to the package.
  /// It is required.
  List<SelectModel<T>> data;

  /// This is a boolean to set multi select or single select.
  /// Default is true.
  bool isMultiSelect;

  /// If it is [true] evry item in [itemList] will be added to selected values.
  /// Default true.
  final bool isCategoryAddAllChildren;

  /// This is a boolean to select category.
  /// Default is true.
  final bool isCategorySelectable;

  /// This is initial selected data.
  /// This data will be add to the [selectedList] when the class is created.
  /// If [isMultiSelect] is false, must be null or length <= 1.
  final List<SelectModel<T>>? initSelected;

  /// This is a list of [ItemModel] selected items.
  final List<SelectModel<T>> selectedList = [];

  /// SelectDataController is a class that will be used to control select data.
  /// Use this constructor to create a [SelectDataController] object.
  /// [data] is required.
  /// If [isMultiSelect] is false, [initSelected] must be null or length <= 1.
  SelectDataController({
    required this.data,
    this.isMultiSelect = true,
    this.isCategoryAddAllChildren = true,
    this.isCategorySelectable = false,
    this.initSelected,
  }) : assert(
          isMultiSelect || initSelected == null || initSelected.length <= 1,
          'For single select, initSelected must be null or length <= 1',
        ) {
    addGroupSelectChip(initSelected);
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

  /// Add items from list of [SelectModel<T>] to the [selectedList],
  /// when items are in the [data] and not in the [selectedList].
  void addGroupSelectChip(List<SelectModel<T>>? singleItemList) {
    if (singleItemList == null) {
      return;
    }

    if (!isMultiSelect) {
      setSingleSelect(singleItemList.first);
    }

    for (var singleItem in singleItemList) {
      addSelectChip(singleItem, false);
    }
    notifyListeners();
  }

  /// Remove items from list of [SelectModel<T>] to the [selectedList],
  /// when items are in the [data] and not in the [selectedList].
  void removeGroupSelectChip(List<SelectModel<T>>? singleItemList) {
    if (singleItemList == null) {
      return;
    }

    for (var singleItem in singleItemList) {
      removeSelectedChip(singleItem, false);
    }
    notifyListeners();
  }

  /// Add single [SelectModel<T>] to the [selectedList],
  /// when items are in the [data] and not in the [selectedList].
  void addSelectChip(
    SelectModel<T>? singleItem, [
    bool notify = true,
  ]) {
    if (singleItem == null) {
      return;
    }

    if (!_singleItemContainsInSelected(singleItem)) {
      selectedList.add(getCategoryFromData(singleItem));
      if (notify) notifyListeners();
    }
  }

  /// Remove single [SelectModel<T>] from the [selectedList],
  /// when items are in the [data] and not in the [selectedList].
  void removeSelectedChip(
    SelectModel<T>? singleItem, [
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

  /// Set single [SelectModel<T>] to the [selectedList],
  /// when items are in the [data] and not in the [selectedList].
  void setSingleSelect(SelectModel<T>? singleItem) {
    if (singleItem == null) {
      return;
    }

    selectedList.clear();
    selectedList.add(getCategoryFromData(singleItem));
    notifyListeners();
  }

  /// Check if the [SelectModel<T>] is in the [selectedList].
  bool _singleItemContainsInSelected(SelectModel<T>? singleItem) {
    if (singleItem == null) {
      return false;
    }

    return selectedList.contains(singleItem);
  }

  SelectModel<T> getCategoryFromData(
    SelectModel<T> patternSingleItem,
  ) {
    late SelectModel<T> returnedVal;
    for (SelectModel<T> item in data) {
      returnedVal = deepContains(patternSingleItem, item) ?? patternSingleItem;
    }
    return returnedVal;
  }

  SelectModel<T>? deepContains(
    SelectModel<T> search,
    SelectModel<T> inThis,
  ) {
    if (search == inThis) {
      return inThis;
    }
    if (inThis.itemList.isEmpty) {
      return null;
    } else {
      SelectModel<T>? contain;
      for (SelectModel<T> inner in inThis.itemList) {
        contain = deepContains(search, inner);
        if (contain != null) break;
      }
      return contain;
    }
  }
}
