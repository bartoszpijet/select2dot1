import 'dart:async';

import 'package:flutter/material.dart';
import 'package:select2dot1/src/dropdown_modal.dart';
import 'package:select2dot1/src/utils/animated_state.dart';

mixin ModalController<T> on AnimatedState<T> {
  void showModal(context) {
    unawaited(
      showModalBottomSheet(
        isScrollControlled: true,
        shape: widget.selectStyle.modalStyle.dropdownModalSettings.shape,
        backgroundColor:
            widget.selectStyle.modalStyle.dropdownModalSettings.backgroundColor,
        barrierColor:
            widget.selectStyle.modalStyle.dropdownModalSettings.barrierColor,
        context: context,
        builder: (context) {
          return DropdownModal(
            selectDataController: widget.selectDataController,
            dropdownContentModalScrollController:
                widget.modalData.dropdownContentModalScrollController,
            searchController: widget.searchController,
            searchDealey: widget.dropdownListData.searchDealey,
            closeSelect: Navigator.pop,
            dropdownContentModalBuilder:
                widget.modalData.dropdownContentModalBuilder,
            titleModalBuilder: widget.modalData.titleModalBuilder,
            doneButtonModalBuilder: widget.modalData.doneButtonModalBuilder,
            isSearchable: widget.isSearchable,
            searchBarModalBuilder: widget.modalData.searchBarModalBuilder,
            loaderBuilder: widget.dropdownListData.loaderBuilder,
            searchEmptyInfoBuilder:
                widget.dropdownListData.searchEmptyInfoBuilder,
            itemListBuilder: widget.dropdownListData.itemListBuilder,
            itemBuilder: widget.dropdownListData.itemBuilder,
            categoryBuilder: widget.dropdownListData.categoryBuilder,
            selectStyle: widget.selectStyle,
          );
        },
      ),
    );
  }
}
