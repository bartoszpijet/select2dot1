import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:select2dot1/src/controllers/search_controller.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class SearchBarOverlay<T> extends StatefulWidget {
  final Duration searchDealey;
  final SearchControllerSelect2dot1<T> searchController;
  final bool isSearchable;
  final SearchBarOverlayBuilder<T>? searchBarOverlayBuilder;
  final SelectStyle selectStyle;

  const SearchBarOverlay({
    super.key,
    required this.searchDealey,
    required this.searchController,
    required this.isSearchable,
    required this.searchBarOverlayBuilder,
    required this.selectStyle,
  });

  @override
  State<SearchBarOverlay<T>> createState() => _SearchBarOverlayState<T>();
}

class _SearchBarOverlayState<T> extends State<SearchBarOverlay<T>> {
  final FocusNode searchBarFocusNode = FocusNode();
  final TextEditingController _searchBarController = TextEditingController();
  bool isFocus = true;

  @override
  void initState() {
    super.initState();
    isFocus = widget
        .selectStyle.overlayStyle.searchBarOverlaySettings.textFieldAutofocus;
    if (widget
        .selectStyle.overlayStyle.searchBarOverlaySettings.textFieldAutofocus) {
      searchBarFocusNode.requestFocus();
    }
    searchBarFocusNode.addListener(_focusOverlayController);
  }

  @override
  void dispose() {
    searchBarFocusNode.removeListener(_focusOverlayController);
    searchBarFocusNode.dispose();
    _searchBarController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searchBarOverlayBuilder != null && widget.isSearchable) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return widget.searchBarOverlayBuilder!(
        context,
        SearchBarOverlayDetails(
          searchController: widget.searchController,
          searchBarController: _searchBarController,
          searchBarFocusNode: searchBarFocusNode,
          isFocus: isFocus,
          onChangedSearchBarController: _onChangedSearchBarOverlayController,
          selectStyle: widget.selectStyle,
        ),
      );
    }

    return LimitedBox(
      // TODO: Let's do it!
      // It has to be limited box + visibility + enable property in TextField to correctly work with animation (IDK why) [I'm working on it.].
      maxHeight: widget.isSearchable ? double.infinity : 0,
      // I know it.
      // ignore: no-equal-arguments
      maxWidth: widget.isSearchable ? double.infinity : 0,
      child: Visibility(
        visible: widget.isSearchable,
        maintainAnimation: true,
        maintainSize: true,
        maintainState: true,
        child: Container(
          margin:
              widget.selectStyle.overlayStyle.searchBarOverlaySettings.margin,
          decoration: _getDecoration(),
          child: RawKeyboardListener(
            focusNode: FocusNode(),
            autofocus: true,
            child: Shortcuts(
              shortcuts: <LogicalKeySet, Intent>{
                LogicalKeySet(LogicalKeyboardKey.escape): const ClearIntent(),
              },
              child: Actions(
                actions: <Type, Action<Intent>>{
                  ClearIntent: ClearAction(_searchBarController),
                },
                child: TextField(
                  focusNode: searchBarFocusNode,
                  controller: _searchBarController,
                  cursorColor: widget.selectStyle.overlayStyle
                          .searchBarOverlaySettings.textFieldCursorColor ??
                      widget.selectStyle.mainColor,
                  autofocus: widget.selectStyle.overlayStyle
                      .searchBarOverlaySettings.textFieldAutofocus,
                  enabled: widget.isSearchable,
                  decoration: _getTextFieldDecoration(),
                  style: _getTextFieldStyle(),
                  onChanged: _onChangedSearchBarOverlayController,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _getTextFieldDecoration() {
    InputDecoration inputDecoration = isFocus
        ? widget.selectStyle.overlayStyle.searchBarOverlaySettings
            .textFieldDecorationFocus
        : widget.selectStyle.overlayStyle.searchBarOverlaySettings
            .textFieldDecorationNoFocus;

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
        suffixIcon: widget.selectStyle.overlayStyle.searchBarOverlaySettings
                .textFieldDecorationSuffixIcon
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _searchBarController.clear,
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
          fontWeight: FontWeight.w100,
          color: widget.selectStyle.inActiveColor,
        ),
      );
    }

    return inputDecoration;
  }

  TextStyle _getTextFieldStyle() {
    TextStyle textFieldStyle =
        widget.selectStyle.overlayStyle.searchBarOverlaySettings.textFieldStyle;

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
        ? widget.selectStyle.overlayStyle.searchBarOverlaySettings
            .boxDecorationFocus
        : widget.selectStyle.overlayStyle.searchBarOverlaySettings
            .boxDecorationNoFocus;

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

  void _focusOverlayController() {
    if (mounted) {
      setState(() {
        isFocus = searchBarFocusNode.hasFocus;
      });
    }
  }

  void _onChangedSearchBarOverlayController(String newValue) {
    EasyDebounce.debounce(
      'search-select-$hashCode',
      widget.searchDealey,
      () {
        unawaited(
          widget.searchController.findSearchDataResults(newValue),
        );
      },
    );
  }
}

class ClearIntent extends Intent {
  const ClearIntent();
}

class ClearAction extends Action<ClearIntent> {
  final TextEditingController searchBarOverlayController;

  ClearAction(this.searchBarOverlayController);

  @override
  // Its nessasary to override this method.
  // ignore: no-object-declaration
  Object? invoke(covariant ClearIntent intent) {
    searchBarOverlayController.clear();

    return null;
  }
}
