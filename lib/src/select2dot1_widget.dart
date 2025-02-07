// NOTE: Select2dot1 is a export file for the library.
// ignore_for_file: prefer-match-file-name

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:select2dot1/src/controllers/modal_controller.dart';
import 'package:select2dot1/src/controllers/overlay_controller.dart';
import 'package:select2dot1/src/controllers/search_controller.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/dropdown_overlay.dart';
import 'package:select2dot1/src/models/selectable_interface.dart';
import 'package:select2dot1/src/pillbox.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/animated_state.dart';
import 'package:select2dot1/src/utils/select_mode.dart';
import 'package:select2dot1/src/utils/typedef.dart';

/// This is the main widget of the library and package.
/// Use this widget to create a select2dot1 widget.
///
///
/// On the first step you need to create a list of data that you want to display in.
/// ```dart
/// static const List<SelectableCategory> exampleData = [
///     SelectableCategory(
///       nameCategory: 'Team Leader',
///       itemList: [
///         SelectableItem(
///           finalLabel: 'David Eubanks',
///           extraInfoSingleItem: 'Full time',
///           avatarSingleItem: CircleAvatar(
///             backgroundColor: Colors.transparent,
///             foregroundColor: Colors.transparent,
///             backgroundImage: AssetImage('assets/images/avatar1.jpg'),
///           ),
///         ),
///         SelectableItem(
///           finalLabel: 'Stuart Resch',
///           extraInfoSingleItem: 'Part time',
///           avatarSingleItem: CircleAvatar(
///             backgroundColor: Colors.blue,
///             child: Text('SR', style: TextStyle(color: Colors.white)),
///           ),
///         ),
///       ],
///     ),
/// ```
///
/// Use Select2dot1 widget and pass your data to it. You can also pass scrollController if you want to use it.
/// ```dart
/// Select2dot1(
///     selectDataController: SelectDataController(data: exampleData),
///     scrollController: scrollController,
///     ),
/// ```
class Select2dot1<T> extends StatefulWidget {
  final SelectMode mode;

  /// This is a controller which contains all the data that you want to display in the widget.
  /// You can also use this controller to get the value of the widget outside the widget.
  /// Also you can controller selected items.
  /// It is required.
  final SelectDataController<T> selectDataController;

  /// Used this to get the value of the widget outside the widget.
  /// It is call every time when the value of the widget is changed.
  final ValueChanged<Iterable<SelectableInterface<T>>>? onChanged;

  /// This is a boolean value that indicates whether the widget is searchable or not.
  /// Default value is [true].
  final bool isSearchable;

  /// Pillbox builder, style, etc.
  final PillboxData<T> pillboxData;

  /// Modal version of select builder, style, etc.
  final ModalData<T> modalData;

  /// Overlay version of select builder, style, etc.
  final OverlayData<T> overlayData;

  /// DropdownList version of select builder, style, etc.
  final DropdownListData<T> dropdownListData;

  /// DropdownButton version of select builder, style, etc.
  final DropdownButtonData<T> dropdownButtonData;

  /// This is a class which contains all the global settings of the widget.
  final SelectStyle selectStyle;

  /// You may extend it to make custom search.
  /// If null default controller will be used).
  final SearchControllerSelect2dot1<T> searchController;

  /// Controller of the data of the widget [selectDataController].
  /// To callback the data of the widget, you can use [selectDataController] to get the data
  /// or use [onChanged] to get the data.
  /// Pass [scrollController] to the widget to control anchor position of dropdown menu
  /// Set [isSearchable] to false to disable search bar
  /// Use builder to customize package by yourself.
  /// If you want you can also use the settings to customize the widget.
  Select2dot1({
    super.key,
    this.mode = SelectMode.auto,
    required this.selectDataController,
    this.onChanged,
    this.isSearchable = true,
    this.pillboxData = const PillboxData(),
    this.modalData = const ModalData(),
    this.overlayData = const OverlayData(),
    this.dropdownListData = const DropdownListData(),
    this.dropdownButtonData = const DropdownButtonData(),
    this.selectStyle = const SelectStyle(),
    SearchControllerSelect2dot1<T>? searchController,
    // It's done like this bc other method dosen't work.
  }) : searchController = searchController ??
            SearchControllerSelect2dot1<T>(selectDataController.data);

  @override
  State<Select2dot1<T>> createState() => _Select2dot1State<T>();
}

class _Select2dot1State<T> extends AnimatedState<T>
    with OverlayController<T>, ModalController<T> {
  // Its ok.
  //ignore: avoid-late-keyword
  late final SelectDataController<T> selectDataController;

  // Its ok.
  // ignore: avoid-late-keyword
  late final LayerLink layerLink;

  // Its ok.
  // ignore: avoid-late-keyword
  late final double? appBarMaxHeightTemp;

  @override
  void initState() {
    super.initState();
    appBarMaxHeightTemp = Scaffold.maybeOf(context)?.appBarMaxHeight;

    selectDataController = widget.selectDataController;
    if (widget.onChanged != null) {
      selectDataController.addListener(_dataOutFromPackage);
    }

    if (!widget.mode.isModal) {
      layerLink = LayerLink();
    }
  }

  @override
  void dispose() {
    if (widget.onChanged != null) {
      selectDataController.removeListener(_dataOutFromPackage);
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Select2dot1<T> oldWidget) {
    if (!identical(
      oldWidget.selectDataController,
      widget.selectDataController,
    )) {
      log(
        'Warning: Do not create SelectDataController in build! For more information, see the SelectDataController section in pub.dev',
        name: 'Select2dot1Package',
      );
      selectDataController.copyWith(widget.selectDataController);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mode.isModal) {
      return Pillbox.modal(
        mode: widget.mode,
        selectDataController: selectDataController,
        onTap: () => showModal(context),
        isVisibleOverlay: isVisibleOvarlayNotifier,
        pillboxTitleBuilder: widget.pillboxData.pillboxTitleBuilder,
        pillboxTitleSettings:
            widget.selectStyle.pillboxStyle.pillboxTitleSettings,
        pillboxBuilder: widget.pillboxData.pillboxBuilder,
        pillboxSettings: widget.selectStyle.pillboxStyle.pillboxSettings,
        pillboxContentSingleBuilder:
            widget.pillboxData.pillboxContentSingleBuilder,
        pillboxContentMultiBuilder:
            widget.pillboxData.pillboxContentMultiBuilder,
        pillboxContentMultiSettings:
            widget.selectStyle.pillboxStyle.pillboxContentMultiSettings,
        pillboxIconBuilder: widget.pillboxData.pillboxIconBuilder,
        pillboxIconSettings:
            widget.selectStyle.pillboxStyle.pillboxIconSettings,
        selectChipBuilder: widget.dropdownButtonData.selectChipBuilder,
        selectChipSettings: widget.selectStyle.selectChipSettings,
        selectSingleBuilder: widget.dropdownButtonData.selectSingleBuilder,
        selectSingleSettings: widget.selectStyle.selectSingleSettings,
        selectEmptyInfoBuilder:
            widget.dropdownButtonData.selectEmptyInfoBuilder,
        selectEmptyInfoSettings: widget.selectStyle.selectEmptyInfoSettings,
        selectOverloadInfoBuilder:
            widget.dropdownButtonData.selectOverloadInfoBuilder,
        selectOverloadInfoSettings:
            widget.selectStyle.selectOverloadInfoSettings,
        selectStyle: widget.selectStyle,
      );
    }

    return
        /* 
         * Not sure if it still needed
            NotificationListener<SizeChangedLayoutNotification>(
              // A little less pedantic style - its okey.
              // ignore: prefer-extracting-callbacks
              onNotification: (notification) {
                SchedulerBinding.instance.addPostFrameCallback(refreshOverlayState);

                return true;
              },
              child: SizeChangedLayoutNotifier(
                child: 
        */
        OverlayPortal(
      controller: overlayController,
      overlayChildBuilder: (context) => DropdownOverlay(
        selectDataController: selectDataController,
        searchController: widget.searchController,
        searchDealey: widget.dropdownListData.searchDealey,
        closeSelect: (_) => hideOverlay(),
        animationController: getAnimationController,
        layerLink: layerLink,
        appBarMaxHeight: appBarMaxHeightTemp,
        scrollController: widget.dropdownListData.scrollController,
        pillboxLayout: widget
            .selectStyle.pillboxStyle.pillboxContentMultiSettings.pillboxLayout,
        itemListScrollController: widget.overlayData.itemListScrollController,
        dropdownContentOverlayBuilder:
            widget.overlayData.dropdownContentOverlayBuilder,
        dropdownOverlaySettings:
            widget.selectStyle.overlayStyle.dropdownOverlaySettings,
        isSearchable: widget.isSearchable,
        searchBarOverlayBuilder: widget.overlayData.searchBarOverlayBuilder,
        loaderBuilder: widget.dropdownListData.loaderBuilder,
        searchEmptyInfoBuilder: widget.dropdownListData.searchEmptyInfoBuilder,
        itemListBuilder: widget.dropdownListData.itemListBuilder,
        categoryBuilder: widget.dropdownListData.categoryBuilder,
        itemBuilder: widget.dropdownListData.itemBuilder,
        selectStyle: widget.selectStyle,
      ),
      child: Pillbox.overlay(
        mode: widget.mode,
        selectDataController: selectDataController,
        onTap: toogleOverlay,
        isVisibleOverlay: isVisibleOvarlayNotifier,
        pillboxLayerLink: layerLink,
        pillboxTitleBuilder: widget.pillboxData.pillboxTitleBuilder,
        pillboxTitleSettings:
            widget.selectStyle.pillboxStyle.pillboxTitleSettings,
        pillboxBuilder: widget.pillboxData.pillboxBuilder,
        pillboxSettings: widget.selectStyle.pillboxStyle.pillboxSettings,
        pillboxContentSingleBuilder:
            widget.pillboxData.pillboxContentSingleBuilder,
        pillboxContentMultiBuilder:
            widget.pillboxData.pillboxContentMultiBuilder,
        pillboxContentMultiSettings:
            widget.selectStyle.pillboxStyle.pillboxContentMultiSettings,
        pillboxIconBuilder: widget.pillboxData.pillboxIconBuilder,
        pillboxIconSettings:
            widget.selectStyle.pillboxStyle.pillboxIconSettings,
        selectChipBuilder: widget.dropdownButtonData.selectChipBuilder,
        selectChipSettings: widget.selectStyle.selectChipSettings,
        selectSingleBuilder: widget.dropdownButtonData.selectSingleBuilder,
        selectSingleSettings: widget.selectStyle.selectSingleSettings,
        selectEmptyInfoBuilder:
            widget.dropdownButtonData.selectEmptyInfoBuilder,
        selectEmptyInfoSettings: widget.selectStyle.selectEmptyInfoSettings,
        selectOverloadInfoBuilder:
            widget.dropdownButtonData.selectOverloadInfoBuilder,
        selectOverloadInfoSettings:
            widget.selectStyle.selectOverloadInfoSettings,
        selectStyle: widget.selectStyle,
      ),
    );
  }

  void _dataOutFromPackage() {
    if (widget.onChanged != null) {
      // This can't be null anyways.
      // ignore:avoid-non-null-assertion
      widget.onChanged!(selectDataController.selectedList);
    }
  }
}
