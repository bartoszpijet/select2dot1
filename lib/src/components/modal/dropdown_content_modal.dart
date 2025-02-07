import 'package:flutter/material.dart';
import 'package:select2dot1/src/components/item_list_widget.dart';
import 'package:select2dot1/src/components/modal/done_button_modal.dart';
import 'package:select2dot1/src/components/modal/search_bar_modal.dart';
import 'package:select2dot1/src/components/modal/title_modal.dart';
import 'package:select2dot1/src/controllers/search_controller.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class DropdownContentModal<T> extends StatefulWidget {
  final ScrollController scrollController;
  final SelectDataController<T> selectDataController;
  final void Function(BuildContext context) closeSelect;
  final SearchControllerSelect2dot1<T> searchController;
  final Duration searchDealey;
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

  const DropdownContentModal({
    super.key,
    required this.scrollController,
    required this.selectDataController,
    required this.closeSelect,
    required this.searchController,
    required this.searchDealey,
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
          selectStyle: widget.selectStyle,
        ),
      );
    }

    return Container(
      padding:
          widget.selectStyle.modalStyle.dropdownModalSettings.contentPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TitleModal(
                  titleModalBuilder: widget.titleModalBuilder,
                  titleModalSettings:
                      widget.selectStyle.modalStyle.titleModalSettings,
                  selectStyle: widget.selectStyle,
                ),
              ),
              DoneButtonModal(
                doneButtonModalBuilder: widget.doneButtonModalBuilder,
                doneButtonModalSettings:
                    widget.selectStyle.modalStyle.doneButtonModalSettings,
                selectStyle: widget.selectStyle,
              ),
            ],
          ),
          SearchBarModal(
            searchDealey: widget.searchDealey,
            searchController: widget.searchController,
            isSearchable: widget.isSearchable,
            searchBarModalBuilder: widget.searchBarModalBuilder,
            searchBarModalSettings:
                widget.selectStyle.modalStyle.searchBarModalSettings,
            selectStyle: widget.selectStyle,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ItemListWidget<T>.modal(
                scrollController: widget.scrollController,
                searchController: widget.searchController,
                closeSelect: widget.closeSelect,
                selectDataController: widget.selectDataController,
                loaderBuilder: widget.loaderBuilder,
                searchEmptyInfoBuilder: widget.searchEmptyInfoBuilder,
                itemListBuilder: widget.itemListBuilder,
                itemBuilder: widget.itemBuilder,
                categoryBuilder: widget.categoryBuilder,
                selectStyle: widget.selectStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleModal() => TitleModal(
        titleModalBuilder: widget.titleModalBuilder,
        titleModalSettings: widget.selectStyle.modalStyle.titleModalSettings,
        selectStyle: widget.selectStyle,
      );

  Widget _doneButtonModal() => DoneButtonModal(
        doneButtonModalBuilder: widget.doneButtonModalBuilder,
        doneButtonModalSettings:
            widget.selectStyle.modalStyle.doneButtonModalSettings,
        selectStyle: widget.selectStyle,
      );

  Widget _searchBarModal() => SearchBarModal(
        searchDealey: widget.searchDealey,
        searchController: widget.searchController,
        isSearchable: widget.isSearchable,
        searchBarModalBuilder: widget.searchBarModalBuilder,
        searchBarModalSettings:
            widget.selectStyle.modalStyle.searchBarModalSettings,
        selectStyle: widget.selectStyle,
      );

  Widget _listDataViewModal() => ItemListWidget<T>.modal(
        scrollController: widget.scrollController,
        searchController: widget.searchController,
        closeSelect: widget.closeSelect,
        selectDataController: widget.selectDataController,
        loaderBuilder: widget.loaderBuilder,
        searchEmptyInfoBuilder: widget.searchEmptyInfoBuilder,
        itemListBuilder: widget.itemListBuilder,
        itemBuilder: widget.itemBuilder,
        categoryBuilder: widget.categoryBuilder,
        selectStyle: widget.selectStyle,
      );
}
