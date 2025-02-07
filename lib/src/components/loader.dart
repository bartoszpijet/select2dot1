import 'package:flutter/material.dart';
import 'package:select2dot1/src/styles/loader_style.dart';
import 'package:select2dot1/src/styles/select_style.dart';
import 'package:select2dot1/src/utils/event_args.dart';

class Loader extends StatelessWidget {
  final LoaderBuilder? builder;
  final SelectStyle selectStyle;

  const Loader({
    super.key,
    required this.builder,
    required this.selectStyle,
  });

  LoaderStyle get style => selectStyle.loaderStyle;

  @override
  Widget build(BuildContext context) {
    if (builder != null) {
      // This can't be null anyways.
      // ignore: avoid-non-null-assertion
      return builder!(
        context,
        LoaderDetails(selectStyle: selectStyle),
      );
    }

    return Align(
      alignment: style.alignment,
      widthFactor: style.widthFactor,
      heightFactor: style.heightFactor,
      child: Padding(
        padding: style.padding,
        child: const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
