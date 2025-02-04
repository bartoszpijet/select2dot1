import 'package:flutter/material.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/models/selectable_interface.dart';
import 'package:select2dot1/src/settings/global_settings.dart';
import 'package:select2dot1/src/settings/overlay/overlay_item_settings.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class OverlayItemWidget<T> extends StatefulWidget {
  final int deepth;
  final SelectableInterface<T> singleItem;
  final SelectDataController<T> selectDataController;
  final void Function() overlayHide;
  final CategoryItemOverlayBuilder<T>? overlayItemBuilder;
  final OverlayItemSettings overlayItemSettings;
  final GlobalSettings globalSettings;

  const OverlayItemWidget({
    super.key,
    this.deepth = 0,
    required this.singleItem,
    required this.selectDataController,
    required this.overlayHide,
    required this.overlayItemBuilder,
    required this.overlayItemSettings,
    required this.globalSettings,
  });

  @override
  State<OverlayItemWidget<T>> createState() => _CategoryItemOverlayState<T>();
}

class _CategoryItemOverlayState<T> extends State<OverlayItemWidget<T>> {
  bool hover = false;
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
    if (widget.overlayItemBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return widget.overlayItemBuilder!(
        context,
        CategoryItemOverlayDetails(
          singleItem: widget.singleItem,
          selectDataController: widget.selectDataController,
          overlayHide: widget.overlayHide,
          hover: hover,
          isSelected: isSelected,
          onTapSingleItemCategory: _onTapSingleItemCategory,
          globalSettings: widget.globalSettings,
        ),
      );
    }
    Widget text = Text(
      widget.singleItem.finalLabel,
      overflow: widget.overlayItemSettings.textOverflow,
      style: _getNameItemTextStyle(),
    );
    if (widget.overlayItemSettings.showTooltip) {
      text = Tooltip(
        waitDuration: const Duration(seconds: 1),
        message: widget.singleItem.finalLabel,
        child: text,
      );
    }

    return Container(
      margin: widget.overlayItemSettings.margin,
      child: MouseRegion(
        cursor: widget.overlayItemSettings.mouseCursorSelect,
        onHover: mounted ? (event) => setState(() => hover = true) : null,
        onExit: mounted ? (event) => setState(() => hover = false) : null,
        child: GestureDetector(
          onTap: _onTapSingleItemCategory,
          child: Container(
            decoration: _getDecoration(),
            alignment: widget.overlayItemSettings.alignmentGeometry,
            constraints: widget.overlayItemSettings.constraints,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: widget.overlayItemSettings.iconPadding,
                  child: AnimatedOpacity(
                    opacity: isSelected ? 1 : 0,
                    duration: widget.overlayItemSettings.iconAnimationDuration,
                    curve: widget.overlayItemSettings.iconAnimationCurve,
                    child: Icon(
                      widget.overlayItemSettings.iconData,
                      size: widget.overlayItemSettings.iconSize,
                      color: _getIconColor(),
                    ),
                  ),
                ),
                for (int i = 0; i < widget.deepth; i++)
                  widget.overlayItemSettings.indent,
                if (widget.singleItem.icon != null &&
                    widget.overlayItemSettings.showAvatar)
                  Container(
                    height: widget.overlayItemSettings.avatarMaxHeight,
                    width: widget.overlayItemSettings.avatarMaxWidth,
                    margin: widget.overlayItemSettings.avatarMargin,
                    child: FittedBox(
                      child: widget.singleItem.icon,
                    ),
                  ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: widget.overlayItemSettings.textPadding,
                        child: text,
                      ),
                      if (widget.overlayItemSettings.showExtraInfo &&
                          widget.singleItem.extraInfo != null)
                        Container(
                          padding: widget.overlayItemSettings.extraInfoPadding,
                          child: Text(
                            // This can't be null anyways.
                            // ignore: avoid-non-null-assertion
                            widget.singleItem.extraInfo!,
                            overflow: widget
                                .overlayItemSettings.extraInfoTextOverflow,
                            style: _getExtraInfoTextStyle(),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getIconColor() {
    return isSelected
        ? widget.overlayItemSettings.iconSelectedColor ??
            widget.globalSettings.mainColor
        : widget.overlayItemSettings.iconDefaultColor ??
            widget.globalSettings.textColor;
  }

  TextStyle _getExtraInfoTextStyle() {
    TextStyle textStyle = widget.overlayItemSettings.extraInfoTextStyle;

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
        ? widget.overlayItemSettings.selectedTextStyle
        : widget.overlayItemSettings.defaultTextStyle;

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

  BoxDecoration _getDecoration() {
    BoxDecoration decoration = hover
        ? widget.overlayItemSettings.hoverDecoration
        : widget.overlayItemSettings.defaultDecoration;

    if (decoration.color == null) {
      decoration = decoration.copyWith(
        color: hover
            ? widget.globalSettings.hoverListItemColor
            : Colors.transparent,
      );
    }

    return decoration;
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
      widget.overlayHide();
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
