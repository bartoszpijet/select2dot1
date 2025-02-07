import 'package:flutter/material.dart';
import 'package:select2dot1/src/styles/select_empty_info_settings.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class SelectEmptyInfo extends StatelessWidget {
  final SelectEmptyInfoBuilder? selectEmptyInfoBuilder;
  final SelectEmptyInfoSettings selectEmptyInfoSettings;
  final SelectStyle selectStyle;

  const SelectEmptyInfo({
    super.key,
    required this.selectEmptyInfoBuilder,
    required this.selectEmptyInfoSettings,
    required this.selectStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (selectEmptyInfoBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return selectEmptyInfoBuilder!(
        context,
        SelectEmptyInfoDetails(
          selectStyle: selectStyle,
        ),
      );
    }

    return Container(
      padding: selectEmptyInfoSettings.padding,
      child: Text(
        selectEmptyInfoSettings.text,
        style: _getTextStyle(),
      ),
    );
  }

  TextStyle _getTextStyle() {
    TextStyle textStyle = selectEmptyInfoSettings.textStyle;
    textStyle = textStyle.copyWith(fontFamily: selectStyle.fontFamily);

    if (textStyle.color == null) {
      textStyle = textStyle.copyWith(color: selectStyle.inActiveColor);
    }

    return textStyle;
  }
}
