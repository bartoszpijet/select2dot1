import 'package:flutter/material.dart';
import 'package:select2dot1/src/styles/select_overload_info_settings.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class SelectOverloadInfo extends StatelessWidget {
  final int countSelected;
  final SelectOverloadInfoBuilder? selectOverloadInfoBuilder;
  final SelectOverloadInfoSettings selectOverloadInfoSettings;
  final SelectStyle selectStyle;

  const SelectOverloadInfo({
    super.key,
    required this.countSelected,
    required this.selectOverloadInfoBuilder,
    required this.selectOverloadInfoSettings,
    required this.selectStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (selectOverloadInfoBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return selectOverloadInfoBuilder!(
        context,
        SelectOverloadInfoDetails(
          countSelected: countSelected,
          selectStyle: selectStyle,
        ),
      );
    }

    return Container(
      padding: selectOverloadInfoSettings.padding,
      child: Text(
        selectOverloadInfoSettings.firstPartText +
            countSelected.toString() +
            selectOverloadInfoSettings.text,
        style: _getTextStyle(),
      ),
    );
  }

  TextStyle _getTextStyle() {
    TextStyle textStyle = selectOverloadInfoSettings.textStyle;
    textStyle = textStyle.copyWith(fontFamily: selectStyle.fontFamily);

    if (textStyle.color == null) {
      textStyle = textStyle.copyWith(color: selectStyle.textColor);
    }

    return textStyle;
  }
}
