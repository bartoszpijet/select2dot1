import 'package:flutter/material.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/models/selectable_interface.dart';
import 'package:select2dot1/src/styles/select_chip_settings.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class SelectChip<T> extends StatelessWidget {
  final SelectableInterface<T> singleItem;
  final SelectDataController<T> selectDataController;
  final SelectChipBuilder<T>? selectChipBuilder;
  final SelectChipSettings selectChipSettings;
  final SelectStyle selectStyle;

  const SelectChip({
    super.key,
    required this.singleItem,
    required this.selectDataController,
    required this.selectChipBuilder,
    required this.selectChipSettings,
    required this.selectStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (selectChipBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return selectChipBuilder!(
        context,
        SelectChipDetails(
          singleItem: singleItem,
          selectDataController: selectDataController,
          selectStyle: selectStyle,
        ),
      );
    }

    return Container(
      height: selectChipSettings.chipHeight,
      decoration: _getChipDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: MouseRegion(
              cursor: selectChipSettings.textMouseCursor,
              child: Container(
                constraints: selectChipSettings.textBoxConstraints,
                padding: selectChipSettings.textPadding,
                child: singleItem.getLabel?.call(singleItem.value) ??
                    Text(
                      singleItem.label,
                      overflow: selectChipSettings.textOverflow,
                      style: _getChipTextStyle(),
                    ),
              ),
            ),
          ),
          Container(
            height: selectChipSettings.dividerHeight,
            width: selectChipSettings.dividerWidth,
            color: selectChipSettings.dividerColor ?? selectStyle.inActiveColor,
          ),
          GestureDetector(
            onTap: () => selectDataController.removeSelectedChip(singleItem),
            child: MouseRegion(
              cursor: selectChipSettings.iconMouseCursor,
              child: Container(
                padding: selectChipSettings.iconPadding,
                child: Icon(
                  selectChipSettings.iconData,
                  size: selectChipSettings.iconSize,
                  color:
                      selectChipSettings.iconColor ?? selectStyle.inActiveColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _getChipDecoration() {
    BoxDecoration decoration = selectChipSettings.chipDecoration;

    if (decoration.border == null) {
      decoration = decoration.copyWith(
        border: const Border.fromBorderSide(BorderSide()),
      );
    }
    if (decoration.color == null) {
      decoration = decoration.copyWith(color: selectStyle.chipColor);
    }

    return decoration;
  }

  TextStyle _getChipTextStyle() {
    TextStyle textStyle = selectChipSettings.textStyle;
    textStyle = textStyle.copyWith(fontFamily: selectStyle.fontFamily);

    if (textStyle.color == null) {
      textStyle = textStyle.copyWith(color: selectStyle.textColor);
    }

    return textStyle;
  }
}
