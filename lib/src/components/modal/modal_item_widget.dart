import 'package:flutter/material.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/models/select_model.dart';
import 'package:select2dot1/src/settings/global_settings.dart';
import 'package:select2dot1/src/settings/modal/modal_item_settings.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class ModalItemWidget<T> extends StatefulWidget {
  final int deepth;
  final SelectModel<T> singleItem;
  final SelectDataController<T> selectDataController;
  final CategoryItemModalBuilder<T>? modalItemBuilder;
  final ModalItemSettings modalItemSettings;
  final GlobalSettings globalSettings;

  const ModalItemWidget({
    super.key,
    this.deepth = 0,
    required this.singleItem,
    required this.selectDataController,
    required this.modalItemBuilder,
    required this.modalItemSettings,
    required this.globalSettings,
  });

  @override
  State<ModalItemWidget<T>> createState() => _CategoryItemModalState<T>();
}

class _CategoryItemModalState<T> extends State<ModalItemWidget<T>> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    widget.selectDataController.addListener(_selectDataListener);

    isSelected = _isSelected();
  }

  @override
  void dispose() {
    widget.selectDataController.removeListener(_selectDataListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isSelected = _isSelected();

    if (widget.modalItemBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return widget.modalItemBuilder!(
        context,
        CategoryItemModalDetails(
          singleItem: widget.singleItem,
          selectDataController: widget.selectDataController,
          isSelected: isSelected,
          onTapSingleItemCategory: _onTapSingleItemCategory,
          globalSettings: widget.globalSettings,
        ),
      );
    }
    Widget result = Container(
      decoration: widget.modalItemSettings.decoration,
      alignment: widget.modalItemSettings.alignmentGeometry,
      constraints: widget.modalItemSettings.constraints,
      child: Row(
        children: [
          Padding(
            padding: widget.modalItemSettings.iconPadding,
            child: AnimatedOpacity(
              opacity: isSelected ? 1 : 0,
              duration: widget.modalItemSettings.iconAnimationDuration,
              curve: widget.modalItemSettings.iconAnimationCurve,
              child: Icon(
                widget.modalItemSettings.iconData,
                size: widget.modalItemSettings.iconSize,
                color: _getIconColor(),
              ),
            ),
          ),
          for (int i = 0; i < widget.deepth; i++)
            widget.modalItemSettings.indent,
          if (widget.singleItem.avatarSingleItem != null &&
              widget.modalItemSettings.showAvatar)
            Container(
              height: widget.modalItemSettings.avatarMaxHeight,
              width: widget.modalItemSettings.avatarMaxWidth,
              margin: widget.modalItemSettings.avatarMargin,
              child: FittedBox(
                child: widget.singleItem.avatarSingleItem,
              ),
            ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: widget.modalItemSettings.textPadding,
                  child: Text(
                    widget.singleItem.itemName,
                    overflow: widget.modalItemSettings.textOverflow,
                    style: _getNameItemTextStyle(),
                  ),
                ),
                if (widget.modalItemSettings.showExtraInfo &&
                    widget.singleItem.extraInfoSingleItem != null)
                  Container(
                    padding: widget.modalItemSettings.extraInfoPadding,
                    child: Text(
                      // This can't be null anyways.
                      // ignore: avoid-non-null-assertion
                      widget.singleItem.extraInfoSingleItem!,
                      overflow: widget.modalItemSettings.extraInfoTextOverflow,
                      style: _getExtraInfoTextStyle(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );

    if (widget.modalItemSettings.showTooltip) {
      result = Tooltip(
        waitDuration: const Duration(seconds: 1),
        message: widget.singleItem.itemName,
        child: result,
      );
    }

    return Container(
      margin: widget.modalItemSettings.margin,
      child: InkWell(
        onTap: _onTapSingleItemCategory,
        borderRadius: widget.modalItemSettings.inkWellBorderRadius,
        splashColor: widget.modalItemSettings.splashColor,
        highlightColor: widget.modalItemSettings.highlightColor,
        child: result,
      ),
    );
  }

  Color _getIconColor() {
    return isSelected
        ? widget.modalItemSettings.iconSelectedColor ??
            widget.globalSettings.mainColor
        : widget.modalItemSettings.iconDefaultColor ??
            widget.globalSettings.textColor;
  }

  TextStyle _getExtraInfoTextStyle() {
    TextStyle textStyle = widget.modalItemSettings.extraInfoTextStyle;

    if (textStyle.color == null) {
      return textStyle.copyWith(
        color: widget.globalSettings.activeColor,
      );
    }

    if (textStyle.fontFamily == null) {
      return textStyle.copyWith(
        fontFamily: widget.globalSettings.fontFamily,
      );
    }

    return textStyle;
  }

  TextStyle _getNameItemTextStyle() {
    TextStyle textStyle = isSelected
        ? widget.modalItemSettings.selectedTextStyle
        : widget.modalItemSettings.defaultTextStyle;

    if (textStyle.color == null) {
      return textStyle.copyWith(
        color: isSelected
            ? widget.globalSettings.mainColor
            : widget.globalSettings.textColor,
      );
    }

    if (textStyle.fontFamily == null) {
      return textStyle.copyWith(
        fontFamily: widget.globalSettings.fontFamily,
      );
    }

    return textStyle;
  }

  void _onTapSingleItemCategory() {
    if (!isSelected) {
      widget.selectDataController.isMultiSelect
          ? widget.selectDataController.addSelectChip(widget.singleItem)
          : widget.selectDataController.setSingleSelect(widget.singleItem);
    } else {
      widget.selectDataController.removeSelectedChip(widget.singleItem);
    }

    if (!widget.selectDataController.isMultiSelect) {
      Navigator.pop(context);
    }
  }

  bool _isSelected() {
    if (widget.selectDataController.selectedList.contains(widget.singleItem)) {
      return true;
    }

    return false;
  }

  void _selectDataListener() {
    if (isSelected == _isSelected()) return;

    if (mounted) {
      setState(() {
        isSelected = _isSelected();
      });
    }
  }
}
