import 'package:flutter/material.dart';
import 'package:select2dot1/src/components/modal/dropdown_content_modal.dart';
import 'package:select2dot1/src/controllers/search_controller.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class DropdownModal<T> extends StatefulWidget {
  final SelectDataController<T> selectDataController;
  // Its okay.
  // ignore: prefer-correct-identifier-length
  final DraggableScrollableController? dropdownContentModalScrollController;
  final SearchControllerSelect2dot1<T> searchController;
  final Duration searchDealey;
  final void Function(BuildContext context) closeSelect;
  final DropdownContentModalBuilder<T>? dropdownContentModalBuilder;
  final TitleModalBuilder? titleModalBuilder;
  final DoneButtonModalBuilder? doneButtonModalBuilder;
  final bool isSearchable;
  final SearchBarModalBuilder<T>? searchBarModalBuilder;
  final LoaderBuilder? loaderBuilder;
  final SearchEmptyInfoBuilder? searchEmptyInfoBuilder;
  final ItemListBuilder<T>? itemListBuilder;
  final ItemWidgetBuilder<T>? itemBuilder;
  final CategoryWidgetBuilder<T>? categoryBuilder;
  final SelectStyle selectStyle;

  const DropdownModal({
    super.key,
    required this.selectDataController,
    required this.dropdownContentModalScrollController,
    required this.searchController,
    required this.searchDealey,
    required this.closeSelect,
    required this.dropdownContentModalBuilder,
    required this.titleModalBuilder,
    required this.doneButtonModalBuilder,
    required this.isSearchable,
    required this.searchBarModalBuilder,
    required this.loaderBuilder,
    required this.searchEmptyInfoBuilder,
    required this.itemListBuilder,
    required this.itemBuilder,
    required this.categoryBuilder,
    required this.selectStyle,
  });

  @override
  State<DropdownModal<T>> createState() => _DropdownModalState<T>();
}

class _DropdownModalState<T> extends State<DropdownModal<T>> {
  // Its okay, because its initialized in the same line.
  // ignore: avoid-late-keyword, prefer-correct-identifier-length
  late final draggableScrollableController =
      widget.dropdownContentModalScrollController ??
          DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize:
          widget.selectStyle.modalStyle.dropdownModalSettings.initialChildSize,
      minChildSize:
          widget.selectStyle.modalStyle.dropdownModalSettings.minChildSize,
      maxChildSize:
          widget.selectStyle.modalStyle.dropdownModalSettings.maxChildSize,
      expand: false,
      controller: draggableScrollableController,
      builder: (BuildContext context, ScrollController scrollController) {
        return Material(
          color: Colors.transparent,
          child: DropdownContentModal(
            selectDataController: widget.selectDataController,
            searchController: widget.searchController,
            searchDealey: widget.searchDealey,
            closeSelect: widget.closeSelect,
            dropdownContentModalBuilder: widget.dropdownContentModalBuilder,
            titleModalBuilder: widget.titleModalBuilder,
            doneButtonModalBuilder: widget.doneButtonModalBuilder,
            isSearchable: widget.isSearchable,
            searchBarModalBuilder: widget.searchBarModalBuilder,
            loaderBuilder: widget.loaderBuilder,
            searchEmptyInfoBuilder: widget.searchEmptyInfoBuilder,
            scrollController: scrollController,
            itemListBuilder: widget.itemListBuilder,
            itemBuilder: widget.itemBuilder,
            categoryBuilder: widget.categoryBuilder,
            selectStyle: widget.selectStyle,
          ),
        );
      },
    );
  }
}
