import 'package:flutter/material.dart';
import 'package:select2dot1/src/components/pillbox/pillbox_icon.dart';
import 'package:select2dot1/src/components/select_empty_info.dart';
import 'package:select2dot1/src/components/select_single.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/styles/pillbox_icon_settings.dart';
import 'package:select2dot1/src/styles/pillbox_settings.dart';
import 'package:select2dot1/src/styles/select_empty_info_settings.dart';
import 'package:select2dot1/src/styles/select_overload_info_settings.dart';
import 'package:select2dot1/src/styles/select_single_settings.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class PillboxContentSingle<T> extends StatefulWidget {
  final SelectDataController<T> selectDataController;
  final bool hover;
  final ValueNotifier<bool>? isVisibleOvarlay;
  final PillboxContentSingleBuilder<T>? pillboxContentSingleBuilder;
  final PillboxSettings pillboxSettings;
  final PillboxIconBuilder? pillboxIconBuilder;
  final PillboxIconSettings pillboxIconSettings;
  final SelectSingleBuilder<T>? selectSingleBuilder;
  final SelectSingleSettings selectSingleSettings;
  final SelectOverloadInfoBuilder? selectOverloadInfoBuilder;
  final SelectOverloadInfoSettings selectOverloadInfoSettings;
  final SelectEmptyInfoBuilder? selectEmptyInfoBuilder;
  final SelectEmptyInfoSettings selectEmptyInfoSettings;
  final SelectStyle selectStyle;

  const PillboxContentSingle({
    super.key,
    required this.selectDataController,
    required this.hover,
    required this.isVisibleOvarlay,
    required this.pillboxContentSingleBuilder,
    required this.pillboxSettings,
    required this.pillboxIconBuilder,
    required this.pillboxIconSettings,
    required this.selectSingleBuilder,
    required this.selectSingleSettings,
    required this.selectOverloadInfoBuilder,
    required this.selectOverloadInfoSettings,
    required this.selectEmptyInfoBuilder,
    required this.selectEmptyInfoSettings,
    required this.selectStyle,
  });

  @override
  State<PillboxContentSingle<T>> createState() =>
      _PillboxContentSingleState<T>();
}

class _PillboxContentSingleState<T> extends State<PillboxContentSingle<T>> {
  bool isFocus = false;

  @override
  void initState() {
    super.initState();

    widget.isVisibleOvarlay?.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.isVisibleOvarlay?.removeListener(_onFocusChange);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pillboxContentSingleBuilder != null) {
      // It cant be null because of assert above.
      // ignore: avoid-non-null-assertion
      return widget.pillboxContentSingleBuilder!(
        context,
        PillboxContentSingleDetails(
          selectDataController: widget.selectDataController,
          hover: widget.hover,
          isVisibleOvarlay: widget.isVisibleOvarlay,
          isFocus: isFocus,
          onFocusChange: _onFocusChange,
          selectSingle: _selectSingle,
          selectEmptyInfo: _selectEmptyInfo,
          pillboxIcon: _pillboxIcon,
          selectStyle: widget.selectStyle,
        ),
      );
    }

    return Container(
      constraints: widget.pillboxSettings.constraints,
      padding: widget.pillboxSettings.padding,
      margin: widget.pillboxSettings.margin,
      decoration: _getDecoration(),
      child: Row(
        children: [
          Expanded(
            child: widget.selectDataController.selectedList.isEmpty
                ? SelectEmptyInfo(
                    selectEmptyInfoBuilder: widget.selectEmptyInfoBuilder,
                    selectEmptyInfoSettings: widget.selectEmptyInfoSettings,
                    selectStyle: widget.selectStyle,
                  )
                : SelectSingle(
                    singleItem: widget.selectDataController.selectedList.first,
                    selectDataController: widget.selectDataController,
                    selectSingleBuilder: widget.selectSingleBuilder,
                    selectSingleSettings: widget.selectSingleSettings,
                    selectStyle: widget.selectStyle,
                  ),
          ),
          PillboxIcon(
            hover: widget.hover,
            isVisibleOvarlay: widget.isVisibleOvarlay,
            pillboxIconBuilder: widget.pillboxIconBuilder,
            pillboxIconSettings: widget.pillboxIconSettings,
            selectStyle: widget.selectStyle,
          ),
        ],
      ),
    );
  }

  BoxDecoration _getDecoration() {
    BoxDecoration decoration = isFocus
        ? widget.pillboxSettings.focusDecoration
        : widget.hover
            ? widget.pillboxSettings.hoverDecoration
            : widget.selectDataController.selectedList.isNotEmpty
                ? widget.pillboxSettings.activeDecoration
                : widget.pillboxSettings.defaultDecoration;

    if (decoration.border == null) {
      decoration = decoration.copyWith(
        border: Border.fromBorderSide(BorderSide(color: _getBorderColor())),
      );
    }

    return decoration;
  }

  Color _getBorderColor() {
    if (isFocus) {
      return widget.selectStyle.mainColor;
    }

    if (widget.hover) {
      return widget.selectStyle.activeColor;
    }

    if (widget.selectDataController.selectedList.isNotEmpty) {
      return widget.selectStyle.mainColor;
    }

    return widget.selectStyle.inActiveColor;
  }

  void _onFocusChange() {
    if (widget.isVisibleOvarlay == null) {
      return;
    }

    if (mounted) {
      setState(() {
        // It cant be null anyways.
        // ignore: avoid-non-null-assertion
        isFocus = widget.isVisibleOvarlay!.value;
      });
    }
  }

  Widget _selectSingle() => SelectSingle(
        singleItem: widget.selectDataController.selectedList.first,
        selectDataController: widget.selectDataController,
        selectSingleBuilder: widget.selectSingleBuilder,
        selectSingleSettings: widget.selectSingleSettings,
        selectStyle: widget.selectStyle,
      );

  Widget _selectEmptyInfo() => SelectEmptyInfo(
        selectEmptyInfoBuilder: widget.selectEmptyInfoBuilder,
        selectEmptyInfoSettings: widget.selectEmptyInfoSettings,
        selectStyle: widget.selectStyle,
      );

  Widget _pillboxIcon() => PillboxIcon(
        hover: widget.hover,
        isVisibleOvarlay: widget.isVisibleOvarlay,
        pillboxIconBuilder: widget.pillboxIconBuilder,
        pillboxIconSettings: widget.pillboxIconSettings,
        selectStyle: widget.selectStyle,
      );
}
