import 'dart:async';

import 'package:flutter/material.dart';
import 'package:select2dot1/src/components/category_item_widget.dart';
import 'package:select2dot1/src/components/item_widget.dart';
import 'package:select2dot1/src/components/loader.dart';
import 'package:select2dot1/src/components/search_empty_info.dart';
import 'package:select2dot1/src/controllers/search_controller.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/models/category_item.dart';
import 'package:select2dot1/src/models/item_interface.dart';
import 'package:select2dot1/src/models/selectable_category.dart';
import 'package:select2dot1/src/models/selectable_item.dart';
import 'package:select2dot1/src/styles/item_list_style.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';
import 'package:select2dot1/src/utils/select_mode.dart';

class ItemListWidget<T> extends StatefulWidget {
  final SelectMode mode;
  final SearchControllerSelect2dot1<T> searchController;
  final SelectDataController<T> selectDataController;
  final void Function(BuildContext context) closeSelect;
  final ScrollController? scrollController;
  final LoaderBuilder? loaderBuilder;
  final SearchEmptyInfoBuilder? searchEmptyInfoBuilder;
  final ItemListBuilder<T>? itemListBuilder;
  final CategoryWidgetBuilder<T>? categoryBuilder;
  final ItemWidgetBuilder<T>? itemBuilder;
  final SelectStyle selectStyle;

  const ItemListWidget.modal({
    super.key,
    required this.searchController,
    required this.selectDataController,
    required this.closeSelect,
    required this.scrollController,
    required this.loaderBuilder,
    required this.searchEmptyInfoBuilder,
    required this.itemListBuilder,
    required this.categoryBuilder,
    required this.itemBuilder,
    required this.selectStyle,
  }) : mode = SelectMode.modal;

  const ItemListWidget.overlay({
    super.key,
    required this.searchController,
    required this.selectDataController,
    required this.closeSelect,
    required this.scrollController,
    required this.loaderBuilder,
    required this.searchEmptyInfoBuilder,
    required this.itemListBuilder,
    required this.categoryBuilder,
    required this.itemBuilder,
    required this.selectStyle,
  }) : mode = SelectMode.overlay;

  @override
  State<ItemListWidget<T>> createState() => _ItemListWidgetState<T>();
}

class _ItemListWidgetState<T> extends State<ItemListWidget<T>> {
  // Its okay, because its initialized in the same line.
  // ignore: avoid-late-keyword
  late final ScrollController scrollController =
      widget.scrollController ?? ScrollController();
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
    if (widget.scrollController == null) {
      scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemListBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return widget.itemListBuilder!(
        context,
        ItemListDetails<T>(
          searchController: widget.searchController,
          selectDataController: widget.selectDataController,
          closeSelect: widget.closeSelect,
          categoryNameOverlay: _categoryNameOverlay,
          categoryItemOverlay: _categoryItemOverlay,
          searchEmptyInfoOverlay: _searchEmptyInfoOverlay,
          loadingDataOverlay: _loadingDataOverlay,
          selectStyle: widget.selectStyle,
        ),
      );
    }
    ItemListStyle itemListStyle = widget.selectStyle.itemListStyle;
    Widget list = StreamBuilder<List<Widget>>(
      stream: streamController,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader(
            builder: widget.loaderBuilder,
            selectStyle: widget.selectStyle,
          );
        }

        if (snapshot.data == null || (snapshot.data as List).isEmpty) {
          return SearchEmptyInfo(
            builder: widget.searchEmptyInfoBuilder,
            selectStyle: widget.selectStyle,
          );
        }

        return Container(
          margin: itemListStyle.margin,
          padding: itemListStyle.padding,
          child: RawScrollbar(
            trackVisibility: itemListStyle.trackVisibility,
            thumbVisibility: itemListStyle.thumbVisibility,
            controller: scrollController,
            thumbColor:
                itemListStyle.thumbColor ?? widget.selectStyle.activeColor,
            trackColor: itemListStyle.trackColor,
            trackBorderColor: itemListStyle.trackBorderColor,
            shape: itemListStyle.shapeScrollbar,
            radius: itemListStyle.radiusScrollbar,
            thickness: itemListStyle.thicknessScrollbar,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemExtent: itemListStyle.itemExtents,
                controller: scrollController,
                itemBuilder: (context, index) => snapshot.data?[index],
                itemCount: snapshot.data?.length,
              ),
            ),
          ),
        );
      },
    );
    if (widget.mode.isModal) {
      return list;
    } else {
      return AnimatedSize(
        duration: itemListStyle.durationAnimationListDataView,
        curve: itemListStyle.curveAnimationListDataView,
        child: list,
      );
    }
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
          widget.selectStyle.itemListStyle.minLoadDuration,
        ),
    ]);

    yield listDataViewChildren.first as List<Widget>;
  }

  Future<List<Widget>> dataFuture() async {
    List<Widget> listDataViewChildren = [];

    for (ItemInterface<T> item in widget.searchController.getResults) {
      listDataViewChildren.addAll(addItem(item));
    }

    return listDataViewChildren;
  }

  List<Widget> addItem(ItemInterface<T> category, [int deepth = 0]) {
    List<Widget> listDataViewChildren = [];
    if (category is! CategoryItem<T>) {
      listDataViewChildren.add(
        ItemWidget<T>(
          deepth: deepth,
          item: category,
          selectDataController: widget.selectDataController,
          closeSelect: widget.closeSelect,
          itemBuilder: widget.itemBuilder,
          selectStyle: widget.selectStyle,
        ),
      );

      return listDataViewChildren;
    }
    listDataViewChildren.add(
      CategoryItemWidget<T>(
        deepth: deepth,
        category: category,
        selectDataController: widget.selectDataController,
        builder: widget.categoryBuilder,
        selectStyle: widget.selectStyle,
      ),
    );
    for (ItemInterface<T> item in category.childrens) {
      listDataViewChildren.addAll(addItem(item, deepth + 1));
    }

    return listDataViewChildren;
  }

  Widget _categoryNameOverlay(SelectableCategory<T> i) => CategoryItemWidget<T>(
        category: i,
        selectDataController: widget.selectDataController,
        builder: widget.categoryBuilder,
        selectStyle: widget.selectStyle,
      );

  Widget _categoryItemOverlay(SelectableItem<T> i) => ItemWidget<T>(
        item: i,
        selectDataController: widget.selectDataController,
        closeSelect: widget.closeSelect,
        itemBuilder: widget.itemBuilder,
        selectStyle: widget.selectStyle,
      );

  Widget _searchEmptyInfoOverlay() => SearchEmptyInfo(
        builder: widget.searchEmptyInfoBuilder,
        selectStyle: widget.selectStyle,
      );

  Widget _loadingDataOverlay() => Loader(
        builder: widget.loaderBuilder,
        selectStyle: widget.selectStyle,
      );
}
