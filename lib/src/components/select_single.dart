import 'package:flutter/material.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/models/selectable_interface.dart';
import 'package:select2dot1/src/styles/select_single_settings.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class SelectSingle<T> extends StatelessWidget {
  final SelectableInterface<T> singleItem;
  final SelectDataController<T> selectDataController;
  final SelectSingleBuilder<T>? selectSingleBuilder;
  final SelectSingleSettings selectSingleSettings;
  final SelectStyle selectStyle;

  const SelectSingle({
    super.key,
    required this.singleItem,
    required this.selectDataController,
    required this.selectSingleBuilder,
    required this.selectSingleSettings,
    required this.selectStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (selectSingleBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return selectSingleBuilder!(
        context,
        SelectSingleDetails<T>(
          singleItem: singleItem,
          selectDataController: selectDataController,
          selectStyle: selectStyle,
        ),
      );
    }

    return singleItem.getLabel?.call(singleItem.value) ??
        Text(
          singleItem.label,
          overflow: selectSingleSettings.textOverflow,
          style: _getTextStyle(),
        );
  }

  TextStyle _getTextStyle() {
    TextStyle textStyle = selectSingleSettings.textStyle;
    textStyle = textStyle.copyWith(fontFamily: selectStyle.fontFamily);

    if (textStyle.color == null) {
      textStyle = textStyle.copyWith(color: selectStyle.textColor);
    }

    return textStyle;
  }
}
