import 'package:flutter/material.dart';
import 'package:select2dot1/select2dot1.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/models/selectable_interface.dart';
import 'package:select2dot1/src/settings/global_settings.dart';
import 'package:select2dot1/src/settings/overlay/overlay_category_settings.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class OverlayCategoryWidget<T> extends StatefulWidget {
  final int deepth;
  final SelectableInterface<T> singleCategory;
  final SelectDataController<T> selectDataController;
  final CategoryNameOverlayBuilder<T>? overlayCategoryBuilder;
  final OverlayCategorySettings overlayCategorySettings;
  final GlobalSettings globalSettings;

  const OverlayCategoryWidget({
    super.key,
    this.deepth = 0,
    required this.singleCategory,
    required this.selectDataController,
    required this.overlayCategoryBuilder,
    required this.overlayCategorySettings,
    required this.globalSettings,
  });

  @override
  State<OverlayCategoryWidget<T>> createState() =>
      _CategoryNameOverlayState<T>();
}

class _CategoryNameOverlayState<T> extends State<OverlayCategoryWidget<T>> {
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
    if (widget.overlayCategoryBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return widget.overlayCategoryBuilder!(
        context,
        CategoryNameOverlayDetails(
          singleCategory: widget.singleCategory,
          selectDataController: widget.selectDataController,
          hover: hover,
          onTapCategory: _onTapCategory,
          globalSettings: widget.globalSettings,
        ),
      );
    }
    Widget text = Text(
      // This can't be null because of the if statement above.
      // ignore: avoid-non-null-assertion
      widget.singleCategory.finalLabel,
      overflow: widget.overlayCategorySettings.textOverflow,
      style: _getTextStyle(),
    );

    if (widget.overlayCategorySettings.showTooltip) {
      text = Tooltip(
        waitDuration: const Duration(seconds: 1),
        message: widget.singleCategory.finalLabel,
        child: text,
      );
    }

    return Container(
      margin: widget.overlayCategorySettings.margin,
      child: GestureDetector(
        onTap: _onTapCategory,
        child: MouseRegion(
          cursor: widget.selectDataController.isMultiSelect
              ? widget.overlayCategorySettings.mouseCursorSelect
              : SystemMouseCursors.basic,
          onHover: widget.selectDataController.isMultiSelect ? _onHover : null,
          onExit: widget.selectDataController.isMultiSelect ? _onExit : null,
          child: Container(
            decoration: _getDecoration(),
            alignment: widget.overlayCategorySettings.alignmentGeometry,
            constraints: widget.overlayCategorySettings.constraints,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: widget.selectDataController.isCategorySelectable,
                  child: Padding(
                    padding: widget.overlayCategorySettings.iconPadding,
                    child: AnimatedOpacity(
                      opacity: isSelected ? 1 : 0,
                      duration:
                          widget.overlayCategorySettings.iconAnimationDuration,
                      curve: widget.overlayCategorySettings.iconAnimationCurve,
                      child: Icon(
                        widget.overlayCategorySettings.iconData,
                        size: widget.overlayCategorySettings.iconSize,
                        color: _getIconColor(),
                      ),
                    ),
                  ),
                ),
                for (int i = 0; i < widget.deepth; i++)
                  widget.overlayCategorySettings.indent,
                Flexible(
                  child: Padding(
                    padding: widget.overlayCategorySettings.textPadding,
                    child: text,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _getTextStyle() {
    TextStyle textStyle = isSelected
        ? widget.overlayCategorySettings.selectedTextStyle
        : widget.overlayCategorySettings.defaultTextStyle;

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

  Color _getIconColor() {
    return isSelected
        ? widget.overlayCategorySettings.iconSelectedColor ??
            widget.globalSettings.mainColor
        : widget.overlayCategorySettings.iconDefaultColor ??
            widget.globalSettings.textColor;
  }

  BoxDecoration _getDecoration() {
    BoxDecoration decoration = hover
        ? widget.overlayCategorySettings.hoverDecoration
        : widget.overlayCategorySettings.defaultDecoration;

    if (decoration.color == null) {
      decoration = decoration.copyWith(
        color: hover
            ? widget.globalSettings.hoverListItemColor
            : Colors.transparent,
      );
    }

    return decoration;
  }

  void _onHover(_) {
    if (mounted) {
      setState(() {
        hover = true;
      });
    }
  }

  void _onExit(_) {
    if (mounted) {
      setState(() {
        hover = false;
      });
    }
  }

  void _onTapCategory() {
    if (widget.singleCategory is! SelectableCategory<T>) {
      return;
    }
    if (widget.selectDataController.isCategorySelectable) {
      if (!widget.selectDataController.isMultiSelect) {
        widget.selectDataController.selectedList.clear();
      }
      if (widget.selectDataController.selectedList
          .contains(widget.singleCategory)) {
        widget.selectDataController.removeSelectedChip(
          widget.singleCategory,
        );
      } else {
        widget.selectDataController.addSelectChip(widget.singleCategory);
      }
    }

    if (widget.selectDataController.isCategoryAddAllChildren) {
      if (!widget.selectDataController.isMultiSelect) {
        return;
      }
      List<SelectableInterface<T>> itemList =
          (widget.singleCategory as SelectableCategory<T>).childrens;
      //TODO: recurrence add all children.
      if (itemList.every(
        (element) => widget.selectDataController.selectedList.contains(element),
      )) {
        widget.selectDataController.removeGroupSelectChip(itemList);
      } else {
        widget.selectDataController.addGroupSelectChip(itemList);
      }
    }
  }

  bool _isSelected() {
    if (widget.selectDataController.selectedList
        .contains(widget.singleCategory)) {
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
