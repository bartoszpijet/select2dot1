import 'package:flutter/material.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/models/select_model.dart';
import 'package:select2dot1/src/settings/global_settings.dart';
import 'package:select2dot1/src/settings/modal/modal_category_settings.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class ModalCategoryWidget<T> extends StatefulWidget {
  final int deepth;
  final SelectModel<T> singleCategory;
  final SelectDataController<T> selectDataController;
  final CategoryNameModalBuilder<T>? modalCategoryBuilder;
  final ModalCategorySettings modalCategorySettings;
  final GlobalSettings globalSettings;

  const ModalCategoryWidget({
    super.key,
    this.deepth = 0,
    required this.singleCategory,
    required this.selectDataController,
    required this.modalCategoryBuilder,
    required this.modalCategorySettings,
    required this.globalSettings,
  });

  @override
  State<ModalCategoryWidget<T>> createState() => _CategoryItemModalState<T>();
}

class _CategoryItemModalState<T> extends State<ModalCategoryWidget<T>> {
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
    if (widget.modalCategoryBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return widget.modalCategoryBuilder!(
        context,
        CategoryNameModalDetails(
          singleCategory: widget.singleCategory,
          selectDataController: widget.selectDataController,
          onTapCategory: _onTapCategory,
          globalSettings: widget.globalSettings,
        ),
      );
    }

    // if (singleCategory.itemName == null) {
    //   return const SizedBox();
    // }

    return Container(
      margin: widget.modalCategorySettings.margin,
      child: InkWell(
        onTap: _onTapCategory,
        borderRadius: widget.modalCategorySettings.inkWellBorderRadius,
        splashColor: widget.selectDataController.isMultiSelect
            ? widget.modalCategorySettings.splashColor
            : Colors.transparent,
        highlightColor: widget.selectDataController.isMultiSelect
            ? widget.modalCategorySettings.highlightColor
            : Colors.transparent,
        child: Container(
          decoration: widget.modalCategorySettings.decoration,
          alignment: widget.modalCategorySettings.alignmentGeometry,
          constraints: widget.modalCategorySettings.constraints,
          padding: widget.modalCategorySettings.textPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < widget.deepth; i++)
                widget.modalCategorySettings.indent,
              Flexible(
                child: Text(
                  // This can't be null because of the if statement above.
                  // ignore: avoid-non-null-assertion
                  widget.singleCategory.itemName,
                  overflow: widget.modalCategorySettings.textOverflow,
                  style: _getTextStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _getTextStyle() {
    TextStyle textStyle = isSelected
        ? widget.modalCategorySettings.selectedTextStyle
        : widget.modalCategorySettings.defaultTextStyle;

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

  void _onTapCategory() {
    if (!widget.singleCategory.isCategory) {
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
      //TODO: recurrence add all children.
      if (widget.singleCategory.itemList.every(
        (element) => widget.selectDataController.selectedList.contains(element),
      )) {
        widget.selectDataController.removeGroupSelectChip(
          widget.singleCategory.itemList,
        );
      } else {
        widget.selectDataController
            .addGroupSelectChip(widget.singleCategory.itemList);
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
