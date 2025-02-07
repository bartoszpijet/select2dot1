import 'package:flutter/material.dart';
import 'package:select2dot1/src/components/pillbox/pillbox_content_multi.dart';
import 'package:select2dot1/src/components/pillbox/pillbox_content_single.dart';
import 'package:select2dot1/src/controllers/select_data_controller.dart';
import 'package:select2dot1/src/styles/pillbox_content_multi_settings.dart';
import 'package:select2dot1/src/styles/pillbox_icon_settings.dart';
import 'package:select2dot1/src/styles/pillbox_settings.dart';
import 'package:select2dot1/src/styles/select_chip_settings.dart';
import 'package:select2dot1/src/styles/select_empty_info_settings.dart';
import 'package:select2dot1/src/styles/select_overload_info_settings.dart';
import 'package:select2dot1/src/styles/select_single_settings.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';
import 'package:select2dot1/src/utils/select_mode.dart';

class PillboxContent<T> extends StatelessWidget {
  final SelectMode mode;
  final SelectDataController<T> selectDataController;
  final bool hover;
  final ValueNotifier<bool>? isVisibleOvarlay;
  final LayerLink? pillboxLayerLink;
  final PillboxContentSingleBuilder<T>? pillboxContentSingleBuilder;
  final PillboxSettings pillboxSettings;
  final PillboxContentMultiBuilder<T>? pillboxContentMultiBuilder;
  final PillboxContentMultiSettings pillboxContentMultiSettings;
  final PillboxIconBuilder? pillboxIconBuilder;
  final PillboxIconSettings pillboxIconSettings;
  final SelectChipBuilder<T>? selectChipBuilder;
  final SelectChipSettings selectChipSettings;
  final SelectSingleBuilder<T>? selectSingleBuilder;
  final SelectSingleSettings selectSingleSettings;
  final SelectOverloadInfoBuilder? selectOverloadInfoBuilder;
  final SelectOverloadInfoSettings selectOverloadInfoSettings;
  final SelectEmptyInfoBuilder? selectEmptyInfoBuilder;
  final SelectEmptyInfoSettings selectEmptyInfoSettings;
  final SelectStyle selectStyle;

  const PillboxContent({
    super.key,
    required this.mode,
    required this.selectDataController,
    required this.hover,
    required this.isVisibleOvarlay,
    required this.pillboxLayerLink,
    required this.pillboxContentSingleBuilder,
    required this.pillboxSettings,
    required this.pillboxContentMultiBuilder,
    required this.pillboxContentMultiSettings,
    required this.pillboxIconBuilder,
    required this.pillboxIconSettings,
    required this.selectChipBuilder,
    required this.selectChipSettings,
    required this.selectSingleBuilder,
    required this.selectSingleSettings,
    required this.selectOverloadInfoBuilder,
    required this.selectOverloadInfoSettings,
    required this.selectEmptyInfoBuilder,
    required this.selectEmptyInfoSettings,
    required this.selectStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (mode.isModal) {
      return selectDataController.isMultiSelect
          ? PillboxContentMulti(
              selectDataController: selectDataController,
              hover: hover,
              isVisibleOvarlay: isVisibleOvarlay,
              pillboxSettings: pillboxSettings,
              pillboxContentMultiBuilder: pillboxContentMultiBuilder,
              pillboxContentMultiSettings: pillboxContentMultiSettings,
              pillboxIconBuilder: pillboxIconBuilder,
              pillboxIconSettings: pillboxIconSettings,
              selectChipBuilder: selectChipBuilder,
              selectChipSettings: selectChipSettings,
              selectSingleBuilder: selectSingleBuilder,
              selectSingleSettings: selectSingleSettings,
              selectOverloadInfoBuilder: selectOverloadInfoBuilder,
              selectOverloadInfoSettings: selectOverloadInfoSettings,
              selectEmptyInfoBuilder: selectEmptyInfoBuilder,
              selectEmptyInfoSettings: selectEmptyInfoSettings,
              selectStyle: selectStyle,
            )
          : PillboxContentSingle(
              selectDataController: selectDataController,
              hover: hover,
              isVisibleOvarlay: isVisibleOvarlay,
              pillboxContentSingleBuilder: pillboxContentSingleBuilder,
              pillboxSettings: pillboxSettings,
              pillboxIconBuilder: pillboxIconBuilder,
              pillboxIconSettings: pillboxIconSettings,
              selectSingleBuilder: selectSingleBuilder,
              selectSingleSettings: selectSingleSettings,
              selectOverloadInfoBuilder: selectOverloadInfoBuilder,
              selectOverloadInfoSettings: selectOverloadInfoSettings,
              selectEmptyInfoBuilder: selectEmptyInfoBuilder,
              selectEmptyInfoSettings: selectEmptyInfoSettings,
              selectStyle: selectStyle,
            );
    }

    assert(
      pillboxLayerLink != null,
      'PillboxLayerLink is required for desktop platforms',
    );

    return CompositedTransformTarget(
      // It cant be null because of assert above.
      // ignore: avoid-non-null-assertion
      link: pillboxLayerLink!,
      child: selectDataController.isMultiSelect
          ? PillboxContentMulti(
              selectDataController: selectDataController,
              hover: hover,
              isVisibleOvarlay: isVisibleOvarlay,
              pillboxSettings: pillboxSettings,
              pillboxContentMultiBuilder: pillboxContentMultiBuilder,
              pillboxContentMultiSettings: pillboxContentMultiSettings,
              pillboxIconBuilder: pillboxIconBuilder,
              pillboxIconSettings: pillboxIconSettings,
              selectChipBuilder: selectChipBuilder,
              selectChipSettings: selectChipSettings,
              selectSingleBuilder: selectSingleBuilder,
              selectSingleSettings: selectSingleSettings,
              selectOverloadInfoBuilder: selectOverloadInfoBuilder,
              selectOverloadInfoSettings: selectOverloadInfoSettings,
              selectEmptyInfoBuilder: selectEmptyInfoBuilder,
              selectEmptyInfoSettings: selectEmptyInfoSettings,
              selectStyle: selectStyle,
            )
          : PillboxContentSingle(
              selectDataController: selectDataController,
              hover: hover,
              isVisibleOvarlay: isVisibleOvarlay,
              pillboxContentSingleBuilder: pillboxContentSingleBuilder,
              pillboxSettings: pillboxSettings,
              pillboxIconBuilder: pillboxIconBuilder,
              pillboxIconSettings: pillboxIconSettings,
              selectSingleBuilder: selectSingleBuilder,
              selectSingleSettings: selectSingleSettings,
              selectOverloadInfoBuilder: selectOverloadInfoBuilder,
              selectOverloadInfoSettings: selectOverloadInfoSettings,
              selectEmptyInfoBuilder: selectEmptyInfoBuilder,
              selectEmptyInfoSettings: selectEmptyInfoSettings,
              selectStyle: selectStyle,
            ),
    );
  }
}
