import 'package:flutter/material.dart';

import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/models/category_item.dart';
import 'package:select2dot1/src/models/item_interface.dart';
import 'package:select2dot1/src/models/selectable_category.dart';
import 'package:select2dot1/src/models/selectable_interface.dart';
import 'package:select2dot1/src/styles/category_style.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class CategoryItemWidget<T> extends StatefulWidget {
  final int deepth;
  final CategoryItem<T> category;
  final SelectDataController<T> selectDataController;
  final CategoryWidgetBuilder<T>? builder;
  final SelectStyle selectStyle;

  const CategoryItemWidget({
    super.key,
    this.deepth = 0,
    required this.category,
    required this.selectDataController,
    required this.builder,
    required this.selectStyle,
  });

  CategoryStyle get style => selectStyle.categoryStyle;

  @override
  State<CategoryItemWidget<T>> createState() => _CategoryItemWidgetState<T>();
}

class _CategoryItemWidgetState<T> extends State<CategoryItemWidget<T>> {
  final WidgetStatesController _statesController = WidgetStatesController();

  bool get _isSelected =>
      widget.selectDataController.selectedList.contains(widget.category);

  bool get _isStateSelected =>
      _statesController.value.contains(WidgetState.selected);

  @override
  void initState() {
    super.initState();
    widget.selectDataController.addListener(_selectDataListener);

    if (_isSelected) _statesController.update(WidgetState.selected, true);
  }

  @override
  void dispose() {
    widget.selectDataController.removeListener(_selectDataListener);
    _statesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSelectable = widget.selectDataController.isMultiSelect &&
        (widget.category.addAllChildren ||
            (widget.category is SelectableCategory<T> &&
                (widget.category as SelectableCategory<T>).enabled));
    if (widget.builder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return widget.builder!(
        context,
        CategoryWidgetDetails(
          category: widget.category,
          selectDataController: widget.selectDataController,
          statesController: _statesController,
          onTapCategory: isSelectable ? _onTapCategory : null,
          selectStyle: widget.selectStyle,
        ),
      );
    }
    Widget text = widget.category.getLabel?.call(
          widget.category is SelectableCategory<T>
              ? (widget.category as SelectableCategory<T>).value
              : null,
        ) ??
        Text(
          widget.category.label,
          overflow: widget.style.textOverflow,
        );

    if (widget.style.showTooltip) {
      text = Tooltip(
        waitDuration: const Duration(seconds: 1),
        message: widget.category.label,
        child: text,
      );
    }

    return Padding(
      padding: widget.style.margin ?? EdgeInsets.zero,
      child: TextButton.icon(
        onPressed: isSelectable ? _onTapCategory : null,
        style: widget.style.buttonStyle
                ?.merge(CategoryStyle.defaultCategoryButonStyle) ??
            widget.selectStyle.itemStyle.buttonStyle
                ?.merge(CategoryStyle.defaultCategoryButonStyle) ??
            CategoryStyle.defaultCategoryButonStyle,
        statesController: _statesController,
        label: Padding(
          padding: EdgeInsets.only(
            left: widget.style.indent * widget.deepth,
          ),
          child: text,
        ),
        icon: AnimatedOpacity(
          opacity: _isStateSelected ? 1 : 0,
          duration: widget.style.iconAnimationDuration,
          curve: widget.style.iconAnimationCurve,
          child: Icon(widget.style.iconData),
        ),
      ),
    );
  }

  void _onTapCategory() {
    if (widget.category is SelectableCategory<T>) {
      if (widget.selectDataController.selectedList.contains(widget.category)) {
        widget.selectDataController.removeSelectedChip(
          widget.category as SelectableCategory<T>,
        );
      } else {
        widget.selectDataController
            .addSelectChip(widget.category as SelectableCategory<T>);
      }
    }

    if (widget.category.addAllChildren) {
      if (!widget.selectDataController.isMultiSelect) {
        return;
      }
      Iterable<SelectableInterface<T>> itemList = unnestData(
        widget.category.childrens,
      );
      if (itemList.every(
        (element) => widget.selectDataController.selectedList.contains(element),
      )) {
        widget.selectDataController.removeGroupSelectChip(itemList);
      } else {
        widget.selectDataController.addGroupSelectChip(itemList);
      }
    }
  }

  Iterable<SelectableInterface<T>> unnestData(Iterable<ItemInterface<T>> data) {
    List<SelectableInterface<T>> unnestedList = [];
    for (ItemInterface<T> item in data) {
      if (item is SelectableInterface<T>) {
        unnestedList.add(item);
      }
      if (item is CategoryItem<T>) {
        unnestedList.addAll(unnestData(item.childrens));
      }
    }

    return unnestedList;
  }

  void _selectDataListener() {
    bool select = _isSelected;
    if (_isStateSelected == select) return;

    if (mounted) {
      setState(() {
        _statesController.update(WidgetState.selected, select);
      });
    }
  }
}
