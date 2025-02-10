// ignore_for_file: prefer-match-file-name
import 'package:flutter/material.dart';
import 'package:select2dot1/src/controllers/search_controller.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/models/category_item.dart';
import 'package:select2dot1/src/models/item_interface.dart';
import 'package:select2dot1/src/models/selectable_category.dart';
import 'package:select2dot1/src/models/selectable_interface.dart';
import 'package:select2dot1/src/models/selectable_item.dart';
import 'package:select2dot1/src/styles/select_style.dart';

/// This is a function that will be used to build your own title of the pillbox.
typedef PillboxTitleBuilder = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own title of the pillbox.
  BuildContext context,

  /// [pillboxTitleDetails] is a [PillboxTitleDetails] that will be used to build your own title of the pillbox.
  PillboxTitleDetails pillboxTitleDetails,
);

/// This is a class which contains necessary details to build your own title of the pillbox.
class PillboxTitleDetails {
  /// This is a boolean[ValueNotifier] representing if the overlay is visible.
  final ValueNotifier<bool>? isVisibleOvarlay;

  /// This is a boolean representing if the pillbox is hovered.
  bool hover;

  /// This is a boolean representing if the pillbox is focused.
  bool isFocus;

  /// This is emmbedded function services change the focus of the pillbox.
  final void Function() onFocusChange;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [PillboxTitleDetails] class.
  /// Remember: You don't need use all of the parameters.
  PillboxTitleDetails({
    required this.isVisibleOvarlay,
    required this.hover,
    required this.isFocus,
    required this.onFocusChange,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own pillbox.
typedef PillboxBuilder<T> = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own pillbox.
  BuildContext context,

  /// [pillboxDetails] is a [PillboxDetails] that will be used to build your own pillbox.
  PillboxDetails<T> pillboxDetails,
);

/// This is a class which contains necessary details to build your own pillbox.
class PillboxDetails<T> {
  /// This is a [SelectDataController] that will be used to control the selection of the category item and get data from it.
  final SelectDataController<T> selectDataController;

  /// This is embedded function services show the dropdown.
  final void Function() showDropdown;

  /// This is a boolean[ValueNotifier] representing if the overlay is visible.
  final ValueNotifier<bool>? isVisibleOverlay;

  /// This is a [LayerLink] that will be used to link the pillbox to the dropdown.
  final LayerLink? pillboxLayerLink;

  /// This is a boolean representing if the pillbox is hovered.
  bool hover;

  /// This is a function returning a [Widget] of the title of the pillbox.
  final Widget Function() pillboxTitle;

  /// This is a function returning a [Widget] of the content of the pillbox.
  final Widget Function() pillboxContent;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [PillboxDetails] class.
  /// Remember: You don't need use all of the parameters.
  PillboxDetails({
    required this.selectDataController,
    required this.showDropdown,
    required this.isVisibleOverlay,
    required this.pillboxLayerLink,
    required this.hover,
    required this.pillboxTitle,
    required this.pillboxContent,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own multi content of the pillbox.
typedef PillboxContentMultiBuilder<T> = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own multi content of the pillbox.
  BuildContext context,

  /// [pillboxContentMultiDetails] is a [PillboxContentMultiDetails] that will be used to build your own multi content of the pillbox.
  PillboxContentMultiDetails<T> pillboxContentMultiDetails,
);

/// This is a class which contains necessary details to build your own multi content of the pillbox.
class PillboxContentMultiDetails<T> {
  /// This is a [SelectDataController] that will be used to control the selection of the category item and get data from it.
  final SelectDataController<T> selectDataController;

  /// This is a boolean representing if the pillbox is hovered.
  bool hover;

  /// This is a boolean[ValueNotifier] representing if the overlay is visible.
  final ValueNotifier<bool>? isVisibleOvarlay;

  /// This is a boolean representing if the pillbox is focused.
  bool isFocus;

  /// This is embedded function services change the focus of the pillbox.
  final void Function() onFocusChange;

  /// This is a function returning a [Widget] of the the chip of the pillbox.
  final Widget Function(SelectableItem<T> singleItem) selectChip;

  /// This is a function returning a [Widget] of the empty info of the pillbox.
  final Widget Function() selectEmptyInfo;

  /// This is a function returning a [Widget] of the overload info of the pillbox.
  final Widget Function(int countSelected) selectOverloadInfo;

  /// This is a function returning a [Widget] of the icon of the pillbox.
  final Widget Function() pillboxIcon;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [PillboxContentMultiDetails] class.
  /// Remember: You don't need use all of the parameters.
  PillboxContentMultiDetails({
    required this.selectDataController,
    required this.hover,
    required this.isVisibleOvarlay,
    required this.isFocus,
    required this.onFocusChange,
    required this.selectChip,
    required this.selectEmptyInfo,
    required this.selectOverloadInfo,
    required this.pillboxIcon,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own single content of the pillbox.
typedef PillboxContentSingleBuilder<T> = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own single content of the pillbox.
  BuildContext context,

  /// [pillboxContentSingleDetails] is a [PillboxContentSingleDetails] that will be used to build your own single content of the pillbox.
  PillboxContentSingleDetails<T> pillboxContentSingleDetails,
);

/// This is a class which contains necessary details to build your own single content of the pillbox.
class PillboxContentSingleDetails<T> {
  /// This is a [SelectDataController] that will be used to control the selection of the category item and get data from it.
  final SelectDataController<T> selectDataController;

  /// This is a boolean representing if the pillbox is hovered.
  bool hover;

  /// This is a boolean[ValueNotifier] representing if the overlay is visible.
  final ValueNotifier<bool>? isVisibleOvarlay;

  /// This is a boolean representing if the pillbox is focused.
  bool isFocus;

  /// This is embedded function services change the focus of the pillbox.
  final void Function() onFocusChange;

  /// This is a function returning a [Widget] of the single of the pillbox.
  final Widget Function() selectSingle;

  /// This is a function returning a [Widget] of the empty info of the pillbox.
  final Widget Function() selectEmptyInfo;

  /// This is a function returning a [Widget] of the icon of the pillbox.
  final Widget Function() pillboxIcon;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [PillboxContentSingleDetails] class.
  /// Remember: You don't need use all of the parameters.
  PillboxContentSingleDetails({
    required this.selectDataController,
    required this.hover,
    required this.isVisibleOvarlay,
    required this.isFocus,
    required this.onFocusChange,
    required this.selectSingle,
    required this.selectEmptyInfo,
    required this.pillboxIcon,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own icon of the pillbox.
typedef PillboxIconBuilder = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own icon of the pillbox.
  BuildContext context,

  /// [pillboxIconDetails] is a [PillboxIconDetails] that will be used to build your own icon of the pillbox.
  PillboxIconDetails pillboxIconDetails,
);

/// This is a class which contains necessary details to build your own icon of the pillbox.
class PillboxIconDetails {
  /// This is a [ValueNotifier] representing if the overlay is visible.
  final ValueNotifier<bool>? isVisibleOvarlay;

  /// This is a boolean representing if the pillbox is hovered.
  bool hover;

  /// This is a boolean representing if the pillbox is focused.
  bool isFocus;

  /// This is embedded function services change the focus of the pillbox.
  final void Function() onFocusChange;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [PillboxIconDetails] class.
  /// Remember: You don't need use all of the parameters.
  PillboxIconDetails({
    required this.isVisibleOvarlay,
    required this.hover,
    required this.isFocus,
    required this.onFocusChange,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own select chip of the pillbox.
typedef SelectChipBuilder<T> = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own select chip of the pillbox.
  BuildContext context,

  /// [selectChipDetails] is a [SelectChipDetails] that will be used to build your own select chip of the pillbox.
  SelectChipDetails<T> selectChipDetails,
);

/// This is a class which contains necessary details to build your own select chip of the pillbox.
class SelectChipDetails<T> {
  /// This is a [SelectableItem] that will be used to build the select chip of the pillbox.
  final SelectableInterface<T> singleItem;

  /// This is a [SelectDataController] that will be used to control the selection of the category item and get data from it.
  final SelectDataController<T> selectDataController;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [SelectChipDetails] class.
  /// Remember: You don't need use all of the parameters.
  const SelectChipDetails({
    required this.singleItem,
    required this.selectDataController,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own select single of the pillbox.
typedef SelectSingleBuilder<T> = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own select single of the pillbox.
  BuildContext context,

  /// [selectSingleDetails] is a [SelectSingleDetails] that will be used to build your own select single of the pillbox.
  SelectSingleDetails<T> selectSingleDetails,
);

/// This is a class which contains necessary details to build your own select single of the pillbox.
class SelectSingleDetails<T> {
  /// This is a [SelectableInterface<T>] that will be used to build the select single of the pillbox.
  final SelectableInterface<T> singleItem;

  /// This is a [SelectDataController] that will be used to control the selection of the category item and get data from it.
  final SelectDataController<T> selectDataController;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [SelectSingleDetails] class.
  /// Remember: You don't need use all of the parameters.
  const SelectSingleDetails({
    required this.singleItem,
    required this.selectDataController,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own empty info of the pillbox.
typedef SelectEmptyInfoBuilder = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own empty info of the pillbox.
  BuildContext context,

  /// [selectEmptyInfoDetails] is a [SelectEmptyInfoDetails] that will be used to build your own empty info of the pillbox.
  SelectEmptyInfoDetails selectEmptyInfoDetails,
);

/// This is a class which contains necessary details to build your own empty info of the pillbox.
class SelectEmptyInfoDetails {
  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [SelectEmptyInfoDetails] class.
  /// Remember: You don't need use all of the parameters.
  const SelectEmptyInfoDetails({
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own overload info of the pillbox.
typedef SelectOverloadInfoBuilder = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own overload info of the pillbox.
  BuildContext context,

  /// [selectOverloadInfoDetails] is a [SelectOverloadInfoDetails] that will be used to build your own overload info of the pillbox.
  SelectOverloadInfoDetails selectOverloadInfoDetails,
);

/// This is a class which contains necessary details to build your own overload info of the pillbox.
class SelectOverloadInfoDetails {
  /// This is a int representing the number of selected items.
  int countSelected;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [SelectOverloadInfoDetails] class.
  /// Remember: You don't need use all of the parameters.
  SelectOverloadInfoDetails({
    required this.countSelected,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own dropdown content (overlay).
typedef DropdownContentOverlayBuilder<T> = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own dropdown content (overlay).
  BuildContext context,

  /// [dropdownContentOverlayDetails] is a [DropdownContentOverlayDetails] that will be used to build your own dropdown content (overlay).
  DropdownContentOverlayDetails<T> dropdownContentOverlayDetails,
);

/// This is a class which contains necessary details to build your own dropdown content (overlay).
class DropdownContentOverlayDetails<T> {
  /// This is a [SelectDataController] that will be used to control the selection of the category item and get data from it.
  final SelectDataController<T> selectDataController;

  /// This is embedded function services hide the overlay of the pillbox.
  final void Function(BuildContext context) closeSelect;

  /// This is a [LayerLink] that will be used to link the dropdown to the pillbox.
  final LayerLink layerLink;

  /// This is a [ScrollController] that will be used to controll the scroll of the dropdown.
  final ScrollController? scrollController;

  /// This is a [double] representing the maximum height of the app bar (MaterialAppBar).
  final double? appBarMaxHeight;

  /// This is a [SearchControllerSelect2dot1] that will be used to search the data.
  final SearchControllerSelect2dot1<T> searchController;

  /// This is a function returning a [Widget] of the searchBar.
  final Widget Function() searchBarOverlay;

  /// This is a function returning a [Widget] of the list data view.
  final Widget Function() listDataViewOverlay;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [DropdownContentOverlayDetails] class.
  /// Remember: You don't need use all of the parameters.
  const DropdownContentOverlayDetails({
    required this.selectDataController,
    required this.closeSelect,
    required this.layerLink,
    required this.scrollController,
    required this.appBarMaxHeight,
    required this.searchController,
    required this.searchBarOverlay,
    required this.listDataViewOverlay,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own search bar.
typedef SearchBarOverlayBuilder<T> = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own search bar.
  BuildContext context,

  /// [searchBarOverlayDetails] is a [SearchBarOverlayDetails] that will be used to build your own search bar.
  SearchBarOverlayDetails<T> searchBarOverlayDetails,
);

/// This is a class which contains necessary details to build your own search bar.
class SearchBarOverlayDetails<T> {
  /// This is a [SearchControllerSelect2dot1] that will be used to build the search bar.
  final SearchControllerSelect2dot1<T> searchController;

  /// This is a [FocusNode] that will be used to build the search bar.
  final FocusNode searchBarFocusNode;

  /// This is a [TextEditingController] that will be used to build the search bar.
  final TextEditingController searchBarController;

  /// This is a boolean representing the focus of the search bar.
  bool isFocus;

  /// This is emmbeded function services when the [SearchControllerSelect2dot1] is changed.
  final void Function(String newValue) onChangedSearchBarController;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [SearchBarOverlayDetails] class.
  /// Remember: You don't need use all of the parameters.
  SearchBarOverlayDetails({
    required this.searchController,
    required this.searchBarFocusNode,
    required this.searchBarController,
    required this.isFocus,
    required this.onChangedSearchBarController,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own list data view.
typedef ItemListBuilder<T> = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own list data view.
  BuildContext context,

  /// [itemListDetails] is a [ItemListDetails] that will be used to build your own list data view.
  ItemListDetails<T> itemListDetails,
);

/// This is a class which contains necessary details to build your own list data view.
class ItemListDetails<T> {
  /// This is a [ScrollController] that will be used to control the scroll in list data view.
  final SearchControllerSelect2dot1<T> searchController;

  /// This is a [SelectDataController] that will be used to control the selection of the category item and get data from it.
  final SelectDataController<T> selectDataController;

  /// This is emmbeded function services hide overlay.
  final void Function(BuildContext) closeSelect;

  /// This is a function returning a [Widget] of the categoryNameOverlay.
  final Widget Function(SelectableCategory<T> singleCategory)
      categoryNameOverlay;

  /// This is a function returning a [Widget] of the categoryItemOverlay.
  final Widget Function(SelectableItem<T> singleItem) categoryItemOverlay;

  /// This is a function returning a [Widget] of the search empty info modal.
  final Widget Function() searchEmptyInfoOverlay;

  /// This is a function returning a [Widget] of the loading data modal.
  final Widget Function() loadingDataOverlay;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [ItemListBuilderDetails] class.
  /// Remember: You don't need use all of the parameters.
  const ItemListDetails({
    required this.searchController,
    required this.selectDataController,
    required this.closeSelect,
    required this.categoryNameOverlay,
    required this.categoryItemOverlay,
    required this.searchEmptyInfoOverlay,
    required this.loadingDataOverlay,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build custom labl from [getLabel].
typedef LabelBuilder<T> = Widget Function(T? value);

/// This is a function that will be used to build your own category name.
typedef ItemWidgetBuilder<T> = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own category name.
  BuildContext context,

  /// [categoryItemDetails] is a [ItemWidgetBuilder] that will be used to build your own category name.
  ItemWidgetDetails<T> categoryItemDetails,
);

/// This is a class which contains necessary details to build your own category item.
class ItemWidgetDetails<T> {
  /// This is a [SelectableInterface<T>] that will be used to build the category item.
  final ItemInterface<T> item;

  /// This is a [SelectDataController] that will be used to control the selection of the category item and get data from it.
  final SelectDataController<T> selectDataController;

  /// This is emmbeded function services hide overlay.
  final void Function(BuildContext context) closeSelect;

  /// This is a boolean representing the selected state of the category item.
  WidgetStatesController statesController;

  /// This is emmbeded function services tap on SingleItemCategory.
  final void Function()? onTapItem;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [ItemWidgetDetails] class.
  /// Remember: You don't need use all of the parameters.
  ItemWidgetDetails({
    required this.item,
    required this.selectDataController,
    required this.closeSelect,
    required this.statesController,
    required this.onTapItem,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own category name.
typedef CategoryWidgetBuilder<T> = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own category name.
  BuildContext context,

  /// [categoryWidgetDetails] is a [CategoryWidgetDetails] that will be used to build your own category name.
  CategoryWidgetDetails<T> categoryWidgetDetails,
);

/// This is a class which contains necessary details to build your own category name.
class CategoryWidgetDetails<T> {
  /// This is a [SelectableCategory] that will be used to build the category name.
  final CategoryItem<T> category;

  /// This is a [SelectDataController] that will be used to control the selection of the category item and get data from it.
  final SelectDataController<T> selectDataController;

  /// This is a boolean representing the hover state of the category.
  WidgetStatesController statesController;

  /// This is emmbeded function services tap on category name.
  final void Function()? onTapCategory;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [CategoryWidgetDetails] class.
  /// Remember: You don't need use all of the parameters.
  CategoryWidgetDetails({
    required this.category,
    required this.selectDataController,
    required this.statesController,
    required this.onTapCategory,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own search empty info modal.
typedef SearchEmptyInfoBuilder = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own search empty info modal.
  BuildContext context,

  /// [searchEmptyInfoDetails] is a [SearchEmptyInfoDetails] that will be used to build your own search empty info modal.
  SearchEmptyInfoDetails searchEmptyInfoDetails,
);

/// This is a class which contains necessary details to build your own search empty info modal.
class SearchEmptyInfoDetails {
  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [SearchEmptyInfoDetails] class.
  /// Remember: You don't need use all of the parameters.
  const SearchEmptyInfoDetails({
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own dropdown content modal.
typedef DropdownContentModalBuilder<T> = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own dropdown content modal.
  BuildContext context,

  /// [dropdownContentModalDetails] is a [DropdownContentModalDetails] that will be used to build your own dropdown content modal.
  DropdownContentModalDetails<T> dropdownContentModalDetails,
);

/// This is a class which contains necessary details to build your own dropdown content modal.
class DropdownContentModalDetails<T> {
  /// This is a [ScrollController] that will be used to control the scroll in dropdown content modal.
  final ScrollController scrollController;

  /// This is a [SelectDataController] that will be used to control the selection of the category item and get data from it.
  final SelectDataController<T> selectDataController;

  /// This is a [SearchControllerSelect2dot1] that will be used to control the search.
  final SearchControllerSelect2dot1<T> searchController;

  /// This is a function returning a [Widget] of the title modal.
  final Widget Function() titleModal;

  /// This is a function returning a [Widget] of the done button modal.
  final Widget Function() doneButtonModal;

  /// This is a function returning a [Widget] of the search bar modal.
  final Widget Function() searchBarModal;

  /// This is a function returning a [Widget] of the list data view.
  final Widget Function() listDataViewModal;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [DropdownContentModalDetails] class.
  /// Remember: You don't need use all of the parameters.
  const DropdownContentModalDetails({
    required this.scrollController,
    required this.selectDataController,
    required this.searchController,
    required this.titleModal,
    required this.doneButtonModal,
    required this.searchBarModal,
    required this.listDataViewModal,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own done button modal.
typedef DoneButtonModalBuilder = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own done button modal.
  BuildContext context,

  /// [doneButtonModalDetails] is a [DoneButtonModalDetails] that will be used to build your own done button modal.
  DoneButtonModalDetails doneButtonModalDetails,
);

/// This is a class which contains necessary details to build your own done button modal.
class DoneButtonModalDetails {
  /// This is emmbeded function services hide the modal.
  final void Function() hideModal;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [DoneButtonModalDetails] class.
  /// Remember: You don't need use all of the parameters.
  const DoneButtonModalDetails({
    required this.hideModal,
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own title modal.
typedef TitleModalBuilder = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own title modal.
  BuildContext context,

  /// [tittleModalDetails] is a [TittleModalDetails] that will be used to build your own title modal.
  TittleModalDetails tittleModalDetails,
);

/// This is a class which contains necessary details to build your own title modal.
class TittleModalDetails {
  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [TittleModalDetails] class.
  /// Remember: You don't need use all of the parameters.
  const TittleModalDetails({
    required this.selectStyle,
  });
}

/// This is a function that will be used to build your own search bar modal.
typedef SearchBarModalBuilder<T> = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own search bar modal.
  BuildContext context,

  /// [searchBarModalDetails] is a [SearchBarModalDetails] that will be used to build your own search bar modal.
  SearchBarModalDetails<T> searchBarModalDetails,
);

/// This is a class which contains necessary details to build your own search bar modal.
class SearchBarModalDetails<T> {
  /// This is a [SearchControllerSelect2dot1] that will be used to control the search.
  final SearchControllerSelect2dot1<T> searchController;

  /// This is a [FocusNode] that will be used to control focus of SearchBar.
  final FocusNode searchBarModalFocusNode;

  /// This is a [TextEditingController] of SearchBar that will be used to build the search bar modal.
  final TextEditingController searchBarModalController;

  /// This is a booelan represents the [searchBarModalFocusNode] is focused or not.
  bool isFocus;

  /// This is embedded function services when the [FocusNode] of SearchBar is changed.
  final void Function() focusModalController;

  /// This is emmbeded function services when the [SearchControllerSelect2dot1] is changed.
  final void Function(String newValue) onChangedSearchBarController;

  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [SearchBarModalDetails] class.
  /// Remember: You don't need use all of the parameters.
  SearchBarModalDetails({
    required this.searchController,
    required this.searchBarModalFocusNode,
    required this.searchBarModalController,
    required this.isFocus,
    required this.focusModalController,
    required this.onChangedSearchBarController,
    required this.selectStyle,
  });
}

typedef LoaderBuilder = Widget Function(
  /// [context] is a [BuildContext] that will be used to build your own category item modal.
  BuildContext context,

  /// [LoadingDataDetails] is a [LoadingDataDetails] that will be used to build your own category item modal.
  LoaderDetails loadingDataDetails,
);

class LoaderDetails {
  /// This is a [SelectStyle] that will be used to get the global settings.
  final SelectStyle selectStyle;

  /// Creating an argument constructor of [LoaderDetails] class.
  /// Remember: You don't need use all of the parameters.
  const LoaderDetails({
    required this.selectStyle,
  });
}
