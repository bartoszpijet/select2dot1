import 'package:flutter/material.dart';
import 'package:select2dot1/src/styles/category_style.dart';
import 'package:select2dot1/src/styles/item_list_style.dart';
import 'package:select2dot1/src/styles/item_style.dart';
import 'package:select2dot1/src/styles/loader_style.dart';
import 'package:select2dot1/src/styles/modal/done_button_modal_settings.dart';
import 'package:select2dot1/src/styles/modal/dropdown_modal_settings.dart';
import 'package:select2dot1/src/styles/modal/search_bar_modal_settings.dart';
import 'package:select2dot1/src/styles/modal/title_modal_settings.dart';
import 'package:select2dot1/src/styles/overlay/dropdown_overlay_settings.dart';
import 'package:select2dot1/src/styles/overlay/search_bar_overlay_settings.dart';
import 'package:select2dot1/src/styles/pillbox_content_multi_settings.dart';
import 'package:select2dot1/src/styles/pillbox_icon_settings.dart';
import 'package:select2dot1/src/styles/pillbox_settings.dart';
import 'package:select2dot1/src/styles/pillbox_title_settings.dart';
import 'package:select2dot1/src/styles/search_empty_info_style.dart';
import 'package:select2dot1/src/styles/select_chip_settings.dart';
import 'package:select2dot1/src/styles/select_empty_info_settings.dart';
import 'package:select2dot1/src/styles/select_overload_info_settings.dart';
import 'package:select2dot1/src/styles/select_single_settings.dart';

class SelectStyle {
  final ModalStyle modalStyle;

  final OverlayStyle overlayStyle;

  final PillboxStyle pillboxStyle;

  /// This is a class which contains all the settings of the list data view of dropdown content in overlay mode.
  final ItemListStyle itemListStyle;

  /// This is a class which contains all the settings of the loading data of dropdown content in overlay mode.
  final LoaderStyle loaderStyle;

  /// This is a class which contains all the settings of the search empty info of dropdown content in overlay mode.
  final SearchEmptyInfoStyle searchEmptyInfoStyle;

  /// This is a class which contains all the settings of the category name of list data view in overlay mode.
  final CategoryStyle categoryStyle;

  /// This is a class which contains all the settings of the category item of list data view in overlay mode.
  final ItemStyle itemStyle;

  /// This is a class which contains all the settings of the select chip of the widget.
  final SelectChipSettings selectChipSettings;

  /// This is a class which contains all the settings of the single select of the widget.
  final SelectSingleSettings selectSingleSettings;

  /// This is a class which contains all the settings of the empty info of the widget.
  final SelectEmptyInfoSettings selectEmptyInfoSettings;

  /// This is a class which contains all the settings of the overload info of the widget.
  final SelectOverloadInfoSettings selectOverloadInfoSettings;

  /// The font family to use for the text.
  final String? fontFamily;

  /// The main color used in the widget.
  /// Default value is [Color(0xFF007AFF)].
  final Color mainColor;

  /// The text color used in the widget.
  /// Default value is [Colors.black].
  final Color textColor;

  /// The background color used in the widget.
  /// Default value is [Colors.white].
  final Color backgroundColor;

  /// The inactive color used in the widget.
  /// Default value is [Color(0xFFAAAAAA)].
  final Color inActiveColor;

  /// The active color used in the widget.
  /// Default value is [Color(0xFF808186)].
  final Color activeColor;

  /// The hover list item color used in the widget..
  /// Default value is [Color(0xFFDDEBFF)].
  final Color hoverListItemColor;

  /// The chip color used in the widget.
  /// Default value is [Color(0xFFE4E4E4)].
  final Color chipColor;

  const SelectStyle({
    this.modalStyle = const ModalStyle(),
    this.overlayStyle = const OverlayStyle(),
    this.pillboxStyle = const PillboxStyle(),
    this.itemListStyle = const ItemListStyle(),
    this.loaderStyle = const LoaderStyle(),
    this.searchEmptyInfoStyle = const SearchEmptyInfoStyle(),
    this.categoryStyle = const CategoryStyle(),
    this.itemStyle = const ItemStyle(),
    this.selectChipSettings = const SelectChipSettings(),
    this.selectSingleSettings = const SelectSingleSettings(),
    this.selectEmptyInfoSettings = const SelectEmptyInfoSettings(),
    this.selectOverloadInfoSettings = const SelectOverloadInfoSettings(),
    this.fontFamily,
    this.mainColor = const Color(0xFF007AFF),
    this.textColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.inActiveColor = const Color(0xFFAAAAAA),
    this.activeColor = const Color(0xFF808186),
    this.hoverListItemColor = const Color(0xFFDDEBFF),
    this.chipColor = const Color(0xFFE4E4E4),
  });
}

class ModalStyle {
  /// This is a class which contains all the settings of the dropdown content (modal) of the widget.
  final DropdownModalSettings dropdownModalSettings;

  /// This is a class which contains all the settings of the title of dropdown content in modal mode.
  final TitleModalSettings titleModalSettings;

  /// This is a class which contains all the settings of the done button of dropdown content in modal mode.
  final DoneButtonModalSettings doneButtonModalSettings;

  /// This is a class which contains all the settings of the search bar of the widget in modal mode.
  final SearchBarModalSettings searchBarModalSettings;

  const ModalStyle({
    this.dropdownModalSettings = const DropdownModalSettings(),
    this.titleModalSettings = const TitleModalSettings(),
    this.doneButtonModalSettings = const DoneButtonModalSettings(),
    this.searchBarModalSettings = const SearchBarModalSettings(),
  });
}

class OverlayStyle {
  /// This is a class which contains all the settings of the dropdown content (overlay) of the widget.
  final DropdownOverlaySettings dropdownOverlaySettings;

  /// This is a class which contains all the settings of the search bar of the widget in overlay mode.
  final SearchBarOverlaySettings searchBarOverlaySettings;

  const OverlayStyle({
    this.dropdownOverlaySettings = const DropdownOverlaySettings(),
    this.searchBarOverlaySettings = const SearchBarOverlaySettings(),
  });
}

class PillboxStyle {
  /// This is a class which contains all the settings of the title of the widget.
  final PillboxTitleSettings pillboxTitleSettings;

  /// This is a class which contains all the settings of the pillbox of the widget.
  final PillboxSettings pillboxSettings;

  /// This is a class which contains all the settings of the content of the pillbox in multi select mode.
  final PillboxContentMultiSettings pillboxContentMultiSettings;

  /// This is a class which contains all the settings of the icon of the pillbox.
  final PillboxIconSettings pillboxIconSettings;

  const PillboxStyle({
    this.pillboxTitleSettings = const PillboxTitleSettings(),
    this.pillboxSettings = const PillboxSettings(),
    this.pillboxContentMultiSettings = const PillboxContentMultiSettings(),
    this.pillboxIconSettings = const PillboxIconSettings(),
  });
}
