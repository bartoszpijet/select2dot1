import 'package:flutter/material.dart';
import 'package:select2dot1/src/components/modal/dropdown_content_modal.dart';
import 'package:select2dot1/src/controllers/search_controller.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/settings/global_settings.dart';
import 'package:select2dot1/src/settings/modal/modal_item_settings.dart';
import 'package:select2dot1/src/settings/modal/modal_category_settings.dart';
import 'package:select2dot1/src/settings/modal/done_button_modal_settings.dart';
import 'package:select2dot1/src/settings/modal/dropdown_modal_settings.dart';
import 'package:select2dot1/src/settings/modal/list_data_view_modal_settings.dart';
import 'package:select2dot1/src/settings/modal/loading_data_modal_settings.dart';
import 'package:select2dot1/src/settings/modal/search_bar_modal_settings.dart';
import 'package:select2dot1/src/settings/modal/search_empty_info_modal_settings.dart';
import 'package:select2dot1/src/settings/modal/title_modal_settings.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class DropdownModal<T> extends StatefulWidget {
  final SelectDataController<T> selectDataController;
  // Its okay.
  // ignore: prefer-correct-identifier-length
  final DraggableScrollableController? dropdownContentModalScrollController;
  final SearchControllerSelect2dot1<T> searchController;
  final Duration searchDealey;
  final DropdownContentModalBuilder<T>? dropdownContentModalBuilder;
  final DropdownModalSettings dropdownModalSettings;
  final TitleModalBuilder? titleModalBuilder;
  final TitleModalSettings titleModalSettings;
  final DoneButtonModalBuilder? doneButtonModalBuilder;
  final DoneButtonModalSettings doneButtonModalSettings;
  final bool isSearchable;
  final SearchBarModalBuilder<T>? searchBarModalBuilder;
  final SearchBarModalSettings searchBarModalSettings;
  final LoadingDataModalBuilder? loadingDataModalBuilder;
  final LoadingDataModalSettings loadingDataModalSettings;
  final SearchEmptyInfoModalBuilder? searchEmptyInfoModalBuilder;
  final SearchEmptyInfoModalSettings searchEmptyInfoModalSettings;
  final ListDataViewModalBuilder<T>? listDataViewModalBuilder;
  final ListDataViewModalSettings listDataViewModalSettings;
  final CategoryItemModalBuilder<T>? modalItemBuilder;
  final ModalItemSettings modalItemSettings;
  final CategoryNameModalBuilder<T>? modalCategoryBuilder;
  final ModalCategorySettings modalCategorySettings;
  final GlobalSettings globalSettings;

  const DropdownModal({
    super.key,
    required this.selectDataController,
    required this.dropdownContentModalScrollController,
    required this.searchController,
    required this.searchDealey,
    required this.dropdownContentModalBuilder,
    required this.dropdownModalSettings,
    required this.titleModalBuilder,
    required this.titleModalSettings,
    required this.doneButtonModalBuilder,
    required this.doneButtonModalSettings,
    required this.isSearchable,
    required this.searchBarModalBuilder,
    required this.searchBarModalSettings,
    required this.loadingDataModalBuilder,
    required this.loadingDataModalSettings,
    required this.searchEmptyInfoModalBuilder,
    required this.searchEmptyInfoModalSettings,
    required this.listDataViewModalBuilder,
    required this.listDataViewModalSettings,
    required this.modalItemBuilder,
    required this.modalItemSettings,
    required this.modalCategoryBuilder,
    required this.modalCategorySettings,
    required this.globalSettings,
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
      initialChildSize: widget.dropdownModalSettings.initialChildSize,
      minChildSize: widget.dropdownModalSettings.minChildSize,
      maxChildSize: widget.dropdownModalSettings.maxChildSize,
      expand: false,
      controller: draggableScrollableController,
      builder: (BuildContext context, ScrollController scrollController) {
        return Material(
          color: Colors.transparent,
          child: DropdownContentModal(
            selectDataController: widget.selectDataController,
            searchController: widget.searchController,
            searchDealey: widget.searchDealey,
            dropdownContentModalBuilder: widget.dropdownContentModalBuilder,
            dropdownModalSettings: widget.dropdownModalSettings,
            titleModalBuilder: widget.titleModalBuilder,
            titleModalSettings: widget.titleModalSettings,
            doneButtonModalBuilder: widget.doneButtonModalBuilder,
            doneButtonModalSettings: widget.doneButtonModalSettings,
            isSearchable: widget.isSearchable,
            searchBarModalBuilder: widget.searchBarModalBuilder,
            searchBarModalSettings: widget.searchBarModalSettings,
            loadingDataModalBuilder: widget.loadingDataModalBuilder,
            loadingDataModalSettings: widget.loadingDataModalSettings,
            searchEmptyInfoModalBuilder: widget.searchEmptyInfoModalBuilder,
            searchEmptyInfoModalSettings: widget.searchEmptyInfoModalSettings,
            scrollController: scrollController,
            listDataViewModalBuilder: widget.listDataViewModalBuilder,
            listDataViewModalSettings: widget.listDataViewModalSettings,
            modalItemBuilder: widget.modalItemBuilder,
            modalItemSettings: widget.modalItemSettings,
            modalCategoryBuilder: widget.modalCategoryBuilder,
            modalCategorySettings: widget.modalCategorySettings,
            globalSettings: widget.globalSettings,
          ),
        );
      },
    );
  }
}
