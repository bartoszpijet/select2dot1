import 'package:flutter/material.dart';
import 'package:select2dot1/src/styles/search_empty_info_style.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class SearchEmptyInfo extends StatelessWidget {
  final SearchEmptyInfoBuilder? builder;
  final SelectStyle selectStyle;

  const SearchEmptyInfo({
    super.key,
    required this.builder,
    required this.selectStyle,
  });

  SearchEmptyInfoStyle get style => selectStyle.searchEmptyInfoStyle;

  @override
  Widget build(BuildContext context) {
    if (builder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return builder!(
        context,
        SearchEmptyInfoDetails(
          selectStyle: selectStyle,
        ),
      );
    }

    if (style.isCenter) {
      return Center(
        child: Text(
          style.text,
          style: _getTextStyle(),
        ),
      );
    }

    return Container(
      padding: style.padding,
      child: Text(
        style.text,
        style: _getTextStyle(),
      ),
    );
  }

  TextStyle _getTextStyle() {
    TextStyle textStyle = style.textStyle;
    textStyle = textStyle.copyWith(fontFamily: selectStyle.fontFamily);

    if (textStyle.color == null) {
      textStyle = textStyle.copyWith(color: selectStyle.textColor);
    }

    return textStyle;
  }
}
