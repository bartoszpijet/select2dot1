import 'package:flutter/material.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/models/item_interface.dart';
import 'package:select2dot1/src/models/selectable_interface.dart';
import 'package:select2dot1/src/styles/item_style.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class ItemWidget<T> extends StatefulWidget {
  final int deepth;
  final ItemInterface<T> item;
  final SelectDataController<T> selectDataController;
  final void Function(BuildContext context) closeSelect;
  final ItemWidgetBuilder<T>? itemBuilder;
  final SelectStyle selectStyle;

  const ItemWidget({
    super.key,
    this.deepth = 0,
    required this.item,
    required this.selectDataController,
    required this.closeSelect,
    required this.itemBuilder,
    required this.selectStyle,
  });

  ItemStyle get style => selectStyle.itemStyle;

  @override
  State<ItemWidget<T>> createState() => _ItemWidgetState<T>();
}

class _ItemWidgetState<T> extends State<ItemWidget<T>> {
  final WidgetStatesController _statesController = WidgetStatesController();

  bool get _isSelected =>
      widget.selectDataController.selectedList.contains(widget.item);

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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSelectable = widget.item is SelectableInterface<T>;
    if (widget.itemBuilder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return widget.itemBuilder!(
        context,
        ItemWidgetDetails(
          item: widget.item,
          selectDataController: widget.selectDataController,
          closeSelect: widget.closeSelect,
          statesController: _statesController,
          onTapItem:
              (isSelectable && (widget.item as SelectableInterface<T>).enabled)
                  ? _onTapItem
                  : null,
          selectStyle: widget.selectStyle,
        ),
      );
    }

    Widget text = widget.item.getLabel?.call(
          isSelectable ? (widget.item as SelectableInterface<T>).value : null,
        ) ??
        Text(
          widget.item.label,
          overflow: widget.style.textOverflow,
        );
    if (widget.style.showTooltip) {
      text = Tooltip(
        waitDuration: const Duration(seconds: 1),
        message: widget.item.label,
        child: text,
      );
    }

    return Padding(
      padding: widget.style.margin ?? EdgeInsets.zero,
      child: TextButton.icon(
        onPressed:
            (isSelectable && (widget.item as SelectableInterface<T>).enabled)
                ? _onTapItem
                : null,
        style:
            widget.style.buttonStyle?.merge(ItemStyle.defaultItemButonStyle) ??
                ItemStyle.defaultItemButonStyle,
        statesController: _statesController,
        label: Padding(
          padding: EdgeInsets.only(
            left: widget.style.indent * widget.deepth,
          ),
          child: text,
        ),
        icon: Padding(
          padding: widget.style.iconPadding,
          child: AnimatedOpacity(
            opacity: _isStateSelected ? 1 : 0,
            duration: widget.style.iconAnimationDuration,
            curve: widget.style.iconAnimationCurve,
            child: Icon(widget.style.iconData),
          ),
        ),
      ),
    );
  }

  void _onTapItem() {
    if (widget.item is SelectableInterface<T>) {
      if (!_isStateSelected) {
        widget.selectDataController.isMultiSelect
            ? widget.selectDataController
                .addSelectChip(widget.item as SelectableInterface<T>)
            : widget.selectDataController
                .setSingleSelect(widget.item as SelectableInterface<T>);
      } else {
        widget.selectDataController
            .removeSelectedChip(widget.item as SelectableInterface<T>);
      }

      if (!widget.selectDataController.isMultiSelect) {
        widget.closeSelect(context);
      }
    }
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
