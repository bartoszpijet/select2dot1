import 'dart:async';

import 'package:flutter/material.dart';
import 'package:select2dot1/src/controllers/search_controller.dart';
import 'package:select2dot1/src/styles/modal/search_bar_modal_settings.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class SearchBarModal<T> extends StatefulWidget {
  final Duration searchDealey;
  final SearchControllerSelect2dot1<T> searchController;
  final bool isSearchable;
  final SearchBarModalBuilder<T>? searchBarModalBuilder;
  final SearchBarModalSettings searchBarModalSettings;
  final SelectStyle selectStyle;

  const SearchBarModal({
    super.key,
    required this.searchDealey,
    required this.searchController,
    required this.isSearchable,
    required this.searchBarModalBuilder,
    required this.searchBarModalSettings,
    required this.selectStyle,
  });

  @override
  State<SearchBarModal<T>> createState() => _SearchBarModalState<T>();
}

class _SearchBarModalState<T> extends State<SearchBarModal<T>> {
  final FocusNode searchBarModalFocusNode = FocusNode();
  final TextEditingController searchBarModalController =
      TextEditingController();
  bool isFocus = false;

  @override
  void initState() {
    super.initState();
    isFocus = widget.searchBarModalSettings.textFieldAutofocus;
    if (widget.searchBarModalSettings.textFieldAutofocus) {
      searchBarModalFocusNode.requestFocus();
    }
    searchBarModalFocusNode.addListener(_focusModalController);
    searchBarModalController.addListener(_onChangedSearchBarModalController);
  }

  @override
  void dispose() {
    searchBarModalFocusNode.removeListener(_focusModalController);
    searchBarModalController.removeListener(_onChangedSearchBarModalController);
    searchBarModalFocusNode.dispose();
    searchBarModalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searchBarModalBuilder != null && widget.isSearchable) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return widget.searchBarModalBuilder!(
        context,
        SearchBarModalDetails(
          searchController: widget.searchController,
          searchBarModalFocusNode: searchBarModalFocusNode,
          searchBarModalController: searchBarModalController,
          isFocus: isFocus,
          focusModalController: _focusModalController,
          onChangedSearchBarController: _onChangedSearchBarModalController,
          selectStyle: widget.selectStyle,
        ),
      );
    }

    if (!widget.isSearchable) {
      return Container(
        margin: widget.searchBarModalSettings.marginReplacement,
        height: widget.searchBarModalSettings.heightReplacement,
        width: double.infinity,
        color: widget.searchBarModalSettings.colorReplecment ??
            widget.selectStyle.activeColor,
      );
    }

    return Container(
      margin: widget.searchBarModalSettings.margin,
      decoration: _getDecoration(),
      child: TextField(
        focusNode: searchBarModalFocusNode,
        controller: searchBarModalController,
        cursorColor: widget.searchBarModalSettings.textFieldCursorColor ??
            widget.selectStyle.mainColor,
        autofocus: widget.searchBarModalSettings.textFieldAutofocus,
        decoration: _getTextFieldDecoration(),
        style: _getTextFieldStyle(),
      ),
    );
  }

  InputDecoration _getTextFieldDecoration() {
    InputDecoration inputDecoration = isFocus
        ? widget.searchBarModalSettings.textFieldDecorationFocus
        : widget.searchBarModalSettings.textFieldDecorationNoFocus;

    if (inputDecoration.focusColor == null) {
      inputDecoration = inputDecoration.copyWith(
        focusColor: widget.selectStyle.mainColor,
      );
    }

    if (inputDecoration.focusedBorder == null) {
      inputDecoration = inputDecoration.copyWith(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.selectStyle.mainColor,
            // Its specyfic parameters.
            // ignore: no-magic-number
            width: 2,
          ),
        ),
      );
    }

    if (inputDecoration.suffixIcon == null) {
      Color suffixIconColor = isFocus
          ? widget.selectStyle.mainColor
          : widget.selectStyle.inActiveColor;
      inputDecoration = inputDecoration.copyWith(
        suffixIcon: widget.searchBarModalSettings.textFieldDecorationSuffixIcon
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: searchBarModalController.clear,
                color: suffixIconColor,
              )
            : null,
      );
    }

    if (inputDecoration.hintStyle == null) {
      inputDecoration = inputDecoration.copyWith(
        hintStyle: TextStyle(
          // Its const.
          // ignore: no-magic-number
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: widget.selectStyle.inActiveColor,
        ),
      );
    }

    return inputDecoration;
  }

  TextStyle _getTextFieldStyle() {
    TextStyle textFieldStyle = widget.searchBarModalSettings.textFieldStyle;

    if (textFieldStyle.fontFamily == null) {
      textFieldStyle = textFieldStyle.copyWith(
        fontFamily: widget.selectStyle.fontFamily,
      );
    }

    if (textFieldStyle.color == null) {
      textFieldStyle = textFieldStyle.copyWith(
        color: widget.selectStyle.textColor,
      );
    }

    return textFieldStyle;
  }

  BoxDecoration _getDecoration() {
    BoxDecoration decoration = isFocus
        ? widget.searchBarModalSettings.boxDecorationFocus
        : widget.searchBarModalSettings.boxDecorationNoFocus;

    if (decoration.color == null) {
      decoration = decoration.copyWith(
        color: widget.selectStyle.backgroundColor,
      );
    }

    if (decoration.boxShadow == null) {
      decoration = decoration.copyWith(
        boxShadow: isFocus
            ? [
                BoxShadow(
                  color: widget.selectStyle.mainColor,
                  spreadRadius: 1.0,
                  // Its specyfic parameters.
                  // ignore: no-magic-number
                  blurRadius: 3.0,
                ),
              ]
            : [],
      );
    }

    return decoration;
  }

  void _focusModalController() {
    if (mounted) {
      setState(() {
        isFocus = searchBarModalFocusNode.hasFocus;
      });
    }
  }

  String lastSnapshotSearchText = '';
  void _onChangedSearchBarModalController() {
    String newValue = searchBarModalController.text;
    if (newValue.trim() == '') {
      newValue = '';
    }
    lastSnapshotSearchText = newValue.toString();
    unawaited(
      // Done on purpose.
      // ignore: prefer-async-await
      Future.delayed(widget.searchDealey).then((value) {
        if (lastSnapshotSearchText == newValue) {
          unawaited(
            widget.searchController.findSearchDataResults(newValue),
          );
        }
      }),
    );
  }
}
