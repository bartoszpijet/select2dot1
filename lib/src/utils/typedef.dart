import 'package:flutter/material.dart';

import 'package:select2dot1/src/utils/event_args.dart';

// ignore_for_file: prefer-match-file-name

class PillboxData<T> {
  /// This is a builder that is used to build the title pillbox of the widget.
  final PillboxTitleBuilder? pillboxTitleBuilder;

  /// This is a builder that is used to build the pillbox of the widget.
  final PillboxBuilder<T>? pillboxBuilder;

  /// This is a builder that is used to build the content of the pillbox in multi select mode.
  final PillboxContentMultiBuilder<T>? pillboxContentMultiBuilder;

  /// This is a builder that is used to build the content of the pillbox in single select mode.
  final PillboxContentSingleBuilder<T>? pillboxContentSingleBuilder;

  /// This is a builder that is used to build the icon of the pillbox.
  final PillboxIconBuilder? pillboxIconBuilder;

  const PillboxData({
    this.pillboxTitleBuilder,
    this.pillboxBuilder,
    this.pillboxContentMultiBuilder,
    this.pillboxContentSingleBuilder,
    this.pillboxIconBuilder,
  });
}

class ModalData<T> {
  // Its okay.
  // ignore: prefer-correct-identifier-length
  final DraggableScrollableController? dropdownContentModalScrollController;

  /// This is a builder that is used to build the dropdown content (modal) of the widget.
  final DropdownContentModalBuilder<T>? dropdownContentModalBuilder;

  /// This is a builder that is used to build the title of dropdown content in modal mode.
  final TitleModalBuilder? titleModalBuilder;

  /// This is a builder that is used to build the done button of dropdown content in modal mode.
  final DoneButtonModalBuilder? doneButtonModalBuilder;

  /// This is a builder that is used to build the search bar of the widget in modal mode.
  final SearchBarModalBuilder<T>? searchBarModalBuilder;

  const ModalData({
    this.dropdownContentModalScrollController,
    this.dropdownContentModalBuilder,
    this.titleModalBuilder,
    this.doneButtonModalBuilder,
    this.searchBarModalBuilder,
  });
}

class OverlayData<T> {
  // Its okay.
  // ignore: prefer-correct-identifier-length
  final ScrollController? itemListScrollController;

  /// This is a builder that is used to build the dropdown content (overlay) of the widget.
  final DropdownContentOverlayBuilder<T>? dropdownContentOverlayBuilder;

  /// This is a builder that is used to build the search bar of the widget in overlay mode.
  final SearchBarOverlayBuilder<T>? searchBarOverlayBuilder;

  const OverlayData({
    this.itemListScrollController,
    this.dropdownContentOverlayBuilder,
    this.searchBarOverlayBuilder,
  });
}

class DropdownListData<T> {
  /// This is a builder that is used to build the list data view of dropdown content in overlay mode.
  final ItemListBuilder<T>? itemListBuilder;

  /// Pass it if you want adjustable dropdown anchor.
  final ScrollController? scrollController;

  /// This is a builder that is used to build the loading data of dropdown content in overlay mode.
  final LoaderBuilder? loaderBuilder;

  /// This is a builder that is used to build the search empty info of dropdown content in overlay mode.
  final SearchEmptyInfoBuilder? searchEmptyInfoBuilder;

  /// This is a builder that is used to build the category name of list data view in overlay mode.
  final CategoryWidgetBuilder<T>? categoryBuilder;

  /// This is a builder that is used to build the category item of list data view in overlay mode.
  final ItemWidgetBuilder<T>? itemBuilder;

  /// This is a class which contains all the global settings of the widget.
  final Duration searchDealey;

  const DropdownListData({
    this.itemListBuilder,
    this.scrollController,
    this.loaderBuilder,
    this.searchEmptyInfoBuilder,
    this.categoryBuilder,
    this.itemBuilder,
    this.searchDealey = const Duration(milliseconds: 500),
  });
}

class DropdownButtonData<T> {
  /// This is a builder that is used to build the select chip of the widget.
  final SelectChipBuilder<T>? selectChipBuilder;

  /// This is a builder that is used to build the single select of the widget.
  final SelectSingleBuilder<T>? selectSingleBuilder;

  /// This is a builder that is used to build the empty info in pillbox.
  final SelectEmptyInfoBuilder? selectEmptyInfoBuilder;

  /// This is a builder that is used to build the overload info in pillbox.
  final SelectOverloadInfoBuilder? selectOverloadInfoBuilder;

  const DropdownButtonData({
    this.selectChipBuilder,
    this.selectSingleBuilder,
    this.selectEmptyInfoBuilder,
    this.selectOverloadInfoBuilder,
  });
}
