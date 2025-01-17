import 'package:flutter/material.dart';
import 'package:select2dot1/src/components/modal/done_button_modal.dart';
import 'package:select2dot1/src/components/modal/list_data_view_modal.dart';
import 'package:select2dot1/src/components/modal/search_bar_modal.dart';
import 'package:select2dot1/src/components/modal/title_modal.dart';
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

class DropdownContentModal<T> extends StatefulWidget {
  final ScrollController scrollController;
  final SelectDataController<T> selectDataController;
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

  const DropdownContentModal({
    super.key,
    required this.scrollController,
    required this.selectDataController,
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
  State<DropdownContentModal<T>> createState() =>
      _DropdownContentModalState<T>();
}

class _DropdownContentModalState<T> extends State<DropdownContentModal<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.dropdownContentModalBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return widget.dropdownContentModalBuilder!(
        context,
        DropdownContentModalDetails(
          scrollController: widget.scrollController,
          selectDataController: widget.selectDataController,
          searchController: widget.searchController,
          titleModal: _titleModal,
          doneButtonModal: _doneButtonModal,
          searchBarModal: _searchBarModal,
          listDataViewModal: _listDataViewModal,
          globalSettings: widget.globalSettings,
        ),
      );
    }

    return Container(
      padding: widget.dropdownModalSettings.contentPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TitleModal(
                  titleModalBuilder: widget.titleModalBuilder,
                  titleModalSettings: widget.titleModalSettings,
                  globalSettings: widget.globalSettings,
                ),
              ),
              DoneButtonModal(
                doneButtonModalBuilder: widget.doneButtonModalBuilder,
                doneButtonModalSettings: widget.doneButtonModalSettings,
                globalSettings: widget.globalSettings,
              ),
            ],
          ),
          SearchBarModal(
            searchDealey: widget.searchDealey,
            searchController: widget.searchController,
            isSearchable: widget.isSearchable,
            searchBarModalBuilder: widget.searchBarModalBuilder,
            searchBarModalSettings: widget.searchBarModalSettings,
            globalSettings: widget.globalSettings,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ListDataViewModal(
                scrollController: widget.scrollController,
                searchController: widget.searchController,
                selectDataController: widget.selectDataController,
                loadingDataModalBuilder: widget.loadingDataModalBuilder,
                loadingDataModalSettings: widget.loadingDataModalSettings,
                searchEmptyInfoModalBuilder: widget.searchEmptyInfoModalBuilder,
                searchEmptyInfoModalSettings:
                    widget.searchEmptyInfoModalSettings,
                listDataViewModalBuilder: widget.listDataViewModalBuilder,
                listDataViewModalSettings: widget.listDataViewModalSettings,
                modalItemBuilder: widget.modalItemBuilder,
                modalItemSettings: widget.modalItemSettings,
                modalCategoryBuilder: widget.modalCategoryBuilder,
                modalCategorySettings: widget.modalCategorySettings,
                globalSettings: widget.globalSettings,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleModal() => TitleModal(
        titleModalBuilder: widget.titleModalBuilder,
        titleModalSettings: widget.titleModalSettings,
        globalSettings: widget.globalSettings,
      );

  Widget _doneButtonModal() => DoneButtonModal(
        doneButtonModalBuilder: widget.doneButtonModalBuilder,
        doneButtonModalSettings: widget.doneButtonModalSettings,
        globalSettings: widget.globalSettings,
      );

  Widget _searchBarModal() => SearchBarModal(
        searchDealey: widget.searchDealey,
        searchController: widget.searchController,
        isSearchable: widget.isSearchable,
        searchBarModalBuilder: widget.searchBarModalBuilder,
        searchBarModalSettings: widget.searchBarModalSettings,
        globalSettings: widget.globalSettings,
      );

  Widget _listDataViewModal() => ListDataViewModal(
        scrollController: widget.scrollController,
        searchController: widget.searchController,
        selectDataController: widget.selectDataController,
        loadingDataModalBuilder: widget.loadingDataModalBuilder,
        loadingDataModalSettings: widget.loadingDataModalSettings,
        searchEmptyInfoModalBuilder: widget.searchEmptyInfoModalBuilder,
        searchEmptyInfoModalSettings: widget.searchEmptyInfoModalSettings,
        listDataViewModalBuilder: widget.listDataViewModalBuilder,
        listDataViewModalSettings: widget.listDataViewModalSettings,
        modalItemBuilder: widget.modalItemBuilder,
        modalItemSettings: widget.modalItemSettings,
        modalCategoryBuilder: widget.modalCategoryBuilder,
        modalCategorySettings: widget.modalCategorySettings,
        globalSettings: widget.globalSettings,
      );
}
