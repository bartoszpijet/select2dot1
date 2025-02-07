import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:select2dot1/src/components/item_list_widget.dart';
import 'package:select2dot1/src/components/overlay/search_bar_overlay.dart';
import 'package:select2dot1/src/controllers/search_controller.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class DropdownContentOverlay<T> extends StatefulWidget {
  final SelectDataController<T> selectDataController;
  final SearchControllerSelect2dot1<T> searchController;
  final void Function(BuildContext context) closeSelect;
  final LayerLink layerLink;
  final ScrollController? scrollController;
  final Duration searchDealey;
  final double? appBarMaxHeight;
  // Its okay.
  // ignore: prefer-correct-identifier-length
  final ScrollController? itemListScrollController;
  final DropdownContentOverlayBuilder<T>? dropdownContentOverlayBuilder;
  final bool isSearchable;
  final SearchBarOverlayBuilder<T>? searchBarOverlayBuilder;
  final LoaderBuilder? loaderBuilder;
  final SearchEmptyInfoBuilder? searchEmptyInfoBuilder;
  final ItemListBuilder<T>? itemListBuilder;
  final CategoryWidgetBuilder<T>? categoryBuilder;
  final ItemWidgetBuilder<T>? itemBuilder;
  final SelectStyle selectStyle;

  const DropdownContentOverlay({
    super.key,
    required this.selectDataController,
    required this.searchController,
    required this.closeSelect,
    required this.layerLink,
    required this.scrollController,
    required this.searchDealey,
    required this.appBarMaxHeight,
    required this.itemListScrollController,
    required this.dropdownContentOverlayBuilder,
    required this.isSearchable,
    required this.searchBarOverlayBuilder,
    required this.loaderBuilder,
    required this.searchEmptyInfoBuilder,
    required this.itemListBuilder,
    required this.categoryBuilder,
    required this.itemBuilder,
    required this.selectStyle,
  });

  @override
  State<DropdownContentOverlay<T>> createState() =>
      _DropdownContentOverlayState<T>();
}

class _DropdownContentOverlayState<T> extends State<DropdownContentOverlay<T>> {
  static const dropdownOverlayPadding = 10;
  final keySearchBarOverlay = GlobalKey();
  Size sizeSearchBarOverlay = const Size(0, 0);

  @override
  void initState() {
    super.initState();
    if (widget.dropdownContentOverlayBuilder == null) {
      _calculateSearchBarOverlaySize();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dropdownContentOverlayBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return widget.dropdownContentOverlayBuilder!(
        context,
        DropdownContentOverlayDetails(
          selectDataController: widget.selectDataController,
          closeSelect: widget.closeSelect,
          layerLink: widget.layerLink,
          scrollController: widget.scrollController,
          appBarMaxHeight: widget.appBarMaxHeight,
          searchController: widget.searchController,
          searchBarOverlay: _searchBarOverlay,
          listDataViewOverlay: _listDataViewOverlay,
          selectStyle: widget.selectStyle,
        ),
      );
    }

    return Container(
      decoration: _getDecoration(),
      margin: widget.selectStyle.overlayStyle.dropdownOverlaySettings.margin,
      padding: widget.selectStyle.overlayStyle.dropdownOverlaySettings.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationListener<SizeChangedLayoutNotification>(
            // A little less pedantic style - its okey.
            // ignore: prefer-extracting-callbacks
            onNotification: (notification) {
              _calculateSearchBarOverlaySize();

              return true;
            },
            /* child: SizeChangedLayoutNotifier( */
            child: SearchBarOverlay(
              searchDealey: widget.searchDealey,
              key: keySearchBarOverlay,
              searchController: widget.searchController,
              isSearchable: widget.isSearchable,
              searchBarOverlayBuilder: widget.searchBarOverlayBuilder,
              selectStyle: widget.selectStyle,
            ),
            /* ), */
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: widget
                  .selectStyle.overlayStyle.dropdownOverlaySettings.minHeight,
              maxHeight: _calculateMaxHeight(),
            ),
            child: ItemListWidget<T>.overlay(
              searchController: widget.searchController,
              selectDataController: widget.selectDataController,
              closeSelect: widget.closeSelect,
              scrollController: widget.itemListScrollController,
              loaderBuilder: widget.loaderBuilder,
              searchEmptyInfoBuilder: widget.searchEmptyInfoBuilder,
              itemListBuilder: widget.itemListBuilder,
              categoryBuilder: widget.categoryBuilder,
              itemBuilder: widget.itemBuilder,
              selectStyle: widget.selectStyle,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _getDecoration() {
    BoxDecoration decoration =
        widget.selectStyle.overlayStyle.dropdownOverlaySettings.decoration;

    if (decoration.color == null) {
      decoration = decoration.copyWith(
        color: widget.selectStyle.backgroundColor,
      );
    }

    if (decoration.border == null) {
      decoration = decoration.copyWith(
        border: Border.fromBorderSide(
          BorderSide(color: widget.selectStyle.inActiveColor),
        ),
      );
    }

    if (decoration.boxShadow == null) {
      decoration = decoration.copyWith(
        boxShadow: [
          BoxShadow(
            color: widget.selectStyle.inActiveColor,
            // Its constant.
            // ignore: no-magic-number
            blurRadius: 2.0,
            offset: const Offset(0, 2),
          ),
        ],
      );
    }

    return decoration;
  }

  void _calculateSearchBarOverlaySize() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      assert(keySearchBarOverlay.currentContext != null);
      final RenderObject? renderObject =
          keySearchBarOverlay.currentContext?.findRenderObject();
      assert(renderObject == null || renderObject is RenderBox);

      if (renderObject != null) {
        if (mounted) {
          setState(() {
            sizeSearchBarOverlay = (renderObject as RenderBox).size;
          });
        }
      }
    });
  }

  double _calculateMaxHeight() {
    double viewDimension = widget
            .scrollController?.position.viewportDimension ??
        (MediaQuery.of(context).size.height - (widget.appBarMaxHeight ?? 0));

    double results = viewDimension / 1.5 -
        (widget.layerLink.leaderSize?.height ?? 0) / 2 -
        sizeSearchBarOverlay.height -
        dropdownOverlayPadding;

    if (widget.selectStyle.overlayStyle.dropdownOverlaySettings.maxHeight >
        results) {
      return results >=
              widget.selectStyle.overlayStyle.dropdownOverlaySettings.minHeight
          ? max(
              results,
              // No need.
              // ignore:no-magic-number
              (widget.selectStyle.itemListStyle.itemExtents ?? 40) * 1.5,
            )
          : widget.selectStyle.overlayStyle.dropdownOverlaySettings.minHeight;
    } else {
      return widget.selectStyle.overlayStyle.dropdownOverlaySettings.maxHeight;
    }
  }

  Widget _searchBarOverlay() => SearchBarOverlay<T>(
        searchDealey: widget.searchDealey,
        searchController: widget.searchController,
        isSearchable: widget.isSearchable,
        searchBarOverlayBuilder: widget.searchBarOverlayBuilder,
        selectStyle: widget.selectStyle,
      );

  Widget _listDataViewOverlay() => ItemListWidget<T>.overlay(
        searchController: widget.searchController,
        selectDataController: widget.selectDataController,
        closeSelect: widget.closeSelect,
        scrollController: widget.itemListScrollController,
        loaderBuilder: widget.loaderBuilder,
        searchEmptyInfoBuilder: widget.searchEmptyInfoBuilder,
        itemListBuilder: widget.itemListBuilder,
        categoryBuilder: widget.categoryBuilder,
        itemBuilder: widget.itemBuilder,
        selectStyle: widget.selectStyle,
      );
}
