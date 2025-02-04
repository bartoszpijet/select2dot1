import 'package:flutter/material.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/models/selectable_interface.dart';
import 'package:select2dot1/src/settings/global_settings.dart';
import 'package:select2dot1/src/settings/select_single_settings.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class SelectSingle<T> extends StatelessWidget {
  final SelectableInterface<T> singleItem;
  final SelectDataController<T> selectDataController;
  final SelectSingleBuilder<T>? selectSingleBuilder;
  final SelectSingleSettings selectSingleSettings;
  final GlobalSettings globalSettings;

  const SelectSingle({
    super.key,
    required this.singleItem,
    required this.selectDataController,
    required this.selectSingleBuilder,
    required this.selectSingleSettings,
    required this.globalSettings,
  });

  @override
  Widget build(BuildContext context) {
    if (selectSingleBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return selectSingleBuilder!(
        context,
        SelectSingleDetails(
          singleItem: singleItem,
          selectDataController: selectDataController,
          globalSettings: globalSettings,
        ),
      );
    }

    return Container(
      padding: selectSingleSettings.padding,
      child: Row(
        children: [
          if (singleItem.icon != null && selectSingleSettings.showAvatar)
            Container(
              width: selectSingleSettings.avatarMaxWidth,
              height: selectSingleSettings.avatarMaxHeight,
              margin: selectSingleSettings.avatarMargin,
              child: FittedBox(child: singleItem.icon),
            ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: selectSingleSettings.textPadding,
                  child: Text(
                    singleItem.finalLabel,
                    overflow: selectSingleSettings.textOverflow,
                    style: _getTextStyle(),
                  ),
                ),
                if (singleItem.extraInfo != null &&
                    selectSingleSettings.showExtraInfo)
                  Container(
                    padding: selectSingleSettings.extraInfoPadding,
                    child: Text(
                      // This can't be null anyways.
                      // ignore: avoid-non-null-assertion
                      singleItem.extraInfo!,
                      overflow: selectSingleSettings.extraInfoTextOverflow,
                      style: _getExtraInfoTextStyle(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _getExtraInfoTextStyle() {
    TextStyle textStyle = selectSingleSettings.extraInfoTextStyle;
    textStyle = textStyle.copyWith(fontFamily: globalSettings.fontFamily);

    if (textStyle.color == null) {
      textStyle = textStyle.copyWith(color: globalSettings.activeColor);
    }

    return textStyle;
  }

  TextStyle _getTextStyle() {
    TextStyle textStyle = selectSingleSettings.textStyle;
    textStyle = textStyle.copyWith(fontFamily: globalSettings.fontFamily);

    if (textStyle.color == null) {
      textStyle = textStyle.copyWith(color: globalSettings.textColor);
    }

    return textStyle;
  }
}
