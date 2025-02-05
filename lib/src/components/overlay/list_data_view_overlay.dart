import 'dart:async';

import 'package:flutter/material.dart';
import 'package:select2dot1/src/components/overlay/overlay_category_widget.dart';

import 'package:select2dot1/src/components/overlay/overlay_item_widget.dart';
import 'package:select2dot1/src/components/overlay/loading_data_overlay.dart';
import 'package:select2dot1/src/components/overlay/search_empty_info_overlay.dart';
import 'package:select2dot1/src/controllers/search_controller.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/models/category_item.dart';
import 'package:select2dot1/src/models/item_interface.dart';
import 'package:select2dot1/src/models/selectable_category.dart';
import 'package:select2dot1/src/models/selectable_item.dart';
import 'package:select2dot1/src/models/selectable_interface.dart';
import 'package:select2dot1/src/settings/global_settings.dart';
import 'package:select2dot1/src/settings/overlay/overlay_item_settings.dart';
import 'package:select2dot1/src/settings/overlay/overlay_category_settings.dart';
import 'package:select2dot1/src/settings/overlay/list_data_view_overlay_settings.dart';
import 'package:select2dot1/src/settings/overlay/loading_data_overlay_settings.dart';
import 'package:select2dot1/src/settings/overlay/search_empty_info_overlay_settings.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class ListDataViewOverlay<T> extends StatefulWidget {
  final SearchControllerSelect2dot1<T> searchController;
  final SelectDataController<T> selectDataController;
  final void Function() overlayHide;
  // Its okay.
  // ignore: prefer-correct-identifier-length
  final ScrollController? dropdownContentOverlayScrollController;
  final LoadingDataOverlayBuilder? loadingDataOverlayBuilder;
  final LoadingDataOverlaySettings loadingDataOverlaySettings;
  final SearchEmptyInfoOverlayBuilder? searchEmptyInfoOverlayBuilder;
  final SearchEmptyInfoOverlaySettings searchEmptyInfoOverlaySettings;
  final ListDataViewOverlayBuilder<T>? listDataViewOverlayBuilder;
  final ListDataViewOverlaySettings listDataViewOverlaySettings;
  final CategoryNameOverlayBuilder<T>? overlayCategoryBuilder;
  final OverlayCategorySettings overlayCategorySettings;
  final CategoryItemOverlayBuilder<T>? overlayItemBuilder;
  final OverlayItemSettings overlayItemSettings;
  final GlobalSettings globalSettings;

  const ListDataViewOverlay({
    super.key,
    required this.searchController,
    required this.selectDataController,
    required this.overlayHide,
    required this.dropdownContentOverlayScrollController,
    required this.loadingDataOverlayBuilder,
    required this.loadingDataOverlaySettings,
    required this.searchEmptyInfoOverlayBuilder,
    required this.searchEmptyInfoOverlaySettings,
    required this.listDataViewOverlayBuilder,
    required this.listDataViewOverlaySettings,
    required this.overlayCategoryBuilder,
    required this.overlayCategorySettings,
    required this.overlayItemBuilder,
    required this.overlayItemSettings,
    required this.globalSettings,
  });

  @override
  State<ListDataViewOverlay<T>> createState() => _ListDataViewOverlayState<T>();
}

class _ListDataViewOverlayState<T> extends State<ListDataViewOverlay<T>> {
  // Its okay, because its initialized in the same line.
  // ignore: avoid-late-keyword
  late final ScrollController scrollController =
      widget.dropdownContentOverlayScrollController ?? ScrollController();
  // It's okey.
  // ignore: avoid-late-keyword
  late Stream<List<Widget>> streamController = dataStreamFunc(isInit: true);

  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(searchListener);
  }

  @override
  void dispose() {
    widget.searchController.removeListener(searchListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listDataViewOverlayBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return widget.listDataViewOverlayBuilder!(
        context,
        ListDataViewOverlayDetails(
          searchController: widget.searchController,
          selectDataController: widget.selectDataController,
          overlayHide: widget.overlayHide,
          categoryNameOverlay: _categoryNameOverlay,
          categoryItemOverlay: _categoryItemOverlay,
          searchEmptyInfoOverlay: _searchEmptyInfoOverlay,
          loadingDataOverlay: _loadingDataOverlay,
          globalSettings: widget.globalSettings,
        ),
      );
    }

    return AnimatedSize(
      duration:
          widget.listDataViewOverlaySettings.durationAnimationListDataView,
      curve: widget.listDataViewOverlaySettings.curveAnimationListDataView,
      child: StreamBuilder<List<Widget>>(
        stream: streamController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingDataOverlay(
              loadingDataOverlayBuilder: widget.loadingDataOverlayBuilder,
              loadingDataOverlaySettings: widget.loadingDataOverlaySettings,
              globalSettings: widget.globalSettings,
            );
          }

          if (snapshot.data == null || (snapshot.data as List).isEmpty) {
            return SearchEmptyInfoOverlay(
              searchEmptyInfoOverlayBuilder:
                  widget.searchEmptyInfoOverlayBuilder,
              searchEmptyInfoOverlaySettings:
                  widget.searchEmptyInfoOverlaySettings,
              globalSettings: widget.globalSettings,
            );
          }

          return Container(
            margin: widget.listDataViewOverlaySettings.margin,
            padding: widget.listDataViewOverlaySettings.padding,
            child: RawScrollbar(
              trackVisibility:
                  widget.listDataViewOverlaySettings.trackVisibility,
              thumbVisibility:
                  widget.listDataViewOverlaySettings.thumbVisibility,
              controller: scrollController,
              thumbColor: widget.listDataViewOverlaySettings.thumbColor ??
                  widget.globalSettings.activeColor,
              trackColor: widget.listDataViewOverlaySettings.trackColor,
              trackBorderColor:
                  widget.listDataViewOverlaySettings.trackBorderColor,
              shape: widget.listDataViewOverlaySettings.shapeScrollbar,
              radius: widget.listDataViewOverlaySettings.radiusScrollbar,
              thickness: widget.listDataViewOverlaySettings.thicknessScrollbar,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemExtent: widget.listDataViewOverlaySettings.itemExtents,
                  controller: scrollController,
                  itemBuilder: (context, index) => snapshot.data![index],
                  itemCount: snapshot.data!.length,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void searchListener() {
    if (mounted) {
      setState(() {
        streamController = dataStreamFunc();
      });
    }
  }

  Stream<List<Widget>> dataStreamFunc({bool isInit = false}) async* {
    var listDataViewChildren = await Future.wait([
      dataFuture(),
      if (!isInit)
        Future.delayed(
          widget.listDataViewOverlaySettings.minLoadDuration,
        ),
    ]);

    yield listDataViewChildren.first as List<Widget>;
  }

  Future<List<Widget>> dataFuture() async {
    List<Widget> listDataViewChildren = [];

    for (ItemInterface<T> item in widget.searchController.getResults) {
      listDataViewChildren.addAll(categoryOverlay(item));
    }

    return listDataViewChildren;
  }

  List<Widget> categoryOverlay(ItemInterface<T> category, [int deepth = 0]) {
    List<Widget> listDataViewChildren = [];
    if (category is! CategoryItem<T>) {
      listDataViewChildren.add(
        OverlayItemWidget(
          deepth: deepth,
          singleItem: category,
          selectDataController: widget.selectDataController,
          overlayHide: widget.overlayHide,
          overlayItemBuilder: widget.overlayItemBuilder,
          overlayItemSettings: widget.overlayItemSettings,
          globalSettings: widget.globalSettings,
        ),
      );

      return listDataViewChildren;
    }
    listDataViewChildren.add(
      OverlayCategoryWidget(
        deepth: deepth,
        singleCategory: category,
        selectDataController: widget.selectDataController,
        overlayCategoryBuilder: widget.overlayCategoryBuilder,
        overlayCategorySettings: widget.overlayCategorySettings,
        globalSettings: widget.globalSettings,
      ),
    );
    for (ItemInterface<T> item in category.childrens) {
      listDataViewChildren.addAll(categoryOverlay(item, deepth + 1));
    }

    return listDataViewChildren;
  }

  Widget _categoryNameOverlay(SelectableCategory<T> i) =>
      OverlayCategoryWidget<T>(
        singleCategory: i,
        selectDataController: widget.selectDataController,
        overlayCategoryBuilder: widget.overlayCategoryBuilder,
        overlayCategorySettings: widget.overlayCategorySettings,
        globalSettings: widget.globalSettings,
      );

  Widget _categoryItemOverlay(SelectableItem<T> i) => OverlayItemWidget<T>(
        singleItem: i,
        selectDataController: widget.selectDataController,
        overlayHide: widget.overlayHide,
        overlayItemBuilder: widget.overlayItemBuilder,
        overlayItemSettings: widget.overlayItemSettings,
        globalSettings: widget.globalSettings,
      );

  Widget _searchEmptyInfoOverlay() => SearchEmptyInfoOverlay(
        searchEmptyInfoOverlayBuilder: widget.searchEmptyInfoOverlayBuilder,
        searchEmptyInfoOverlaySettings: widget.searchEmptyInfoOverlaySettings,
        globalSettings: widget.globalSettings,
      );

  Widget _loadingDataOverlay() => LoadingDataOverlay(
        loadingDataOverlayBuilder: widget.loadingDataOverlayBuilder,
        loadingDataOverlaySettings: widget.loadingDataOverlaySettings,
        globalSettings: widget.globalSettings,
      );
}
