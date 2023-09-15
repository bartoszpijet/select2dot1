import 'package:flutter/material.dart';

/// This is a class which contains all the settings of the category name of list data view in overlay mode.
class OverlayCategorySettings {
  /// The mouse cursor when the mouse is hovering over the category name.
  /// Default value is [SystemMouseCursors.click].
  final MouseCursor mouseCursorSelect;

  /// The margin of the category name.
  /// Default value is [EdgeInsets.symmetric(horizontal: 4.0)].
  final EdgeInsetsGeometry? margin;

  /// The alignment of the category name.
  /// Default value is [Alignment.centerLeft].
  final AlignmentGeometry? alignmentGeometry;

  /// The constraints of the category name.
  /// Default value is [BoxConstraints(minHeight: 40)].
  final BoxConstraints constraints;

  /// The decoration of the category name.
  /// Default value is [BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)))].
  final BoxDecoration defaultDecoration;

  /// The decoration of the category name when the mouse is hovering over it.
  /// Default value is [BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)))].
  final BoxDecoration hoverDecoration;

  /// The default color of the icon.
  /// Default value is [null],
  /// because the color of the icon is set by the [GlobalSettings].
  final Color? iconDefaultColor;

  /// The selected color of the icon.
  /// Default value is [null],
  /// because the color of the icon is set by the [GlobalSettings].
  final Color? iconSelectedColor;

  /// The size of the icon.
  /// Default value is [16.0].
  final double? iconSize;

  /// The icon data of the icon.
  /// Default value is [Icons.check].
  final IconData? iconData;

  /// The padding of the icon.
  /// Default value is [EdgeInsets.only(left: 4, right: 3)].
  final EdgeInsetsGeometry iconPadding;

  /// The duration of the icon animation.
  /// Default value is [Duration(milliseconds: 400)].
  final Duration iconAnimationDuration;

  /// The curve of the icon animation.
  /// Default value is [Curves.easeInOutQuart].
  final Curve iconAnimationCurve;

  /// The indent that will be used for nested category.
  /// Default is ``` const SizedBox(width:25) ```.
  final Widget indent;

  /// Will be showing tooltip.
  /// Default it is true.
  final bool showTooltip;

  /// Default text style of the category item.
  /// Default value is [TextStyle(fontSize: 16, fontWeight: FontWeight.w400)].
  final TextStyle defaultTextStyle;

  /// (only if category is selectable) Selected text style of the category item.
  /// Default value is [TextStyle(fontSize: 16, fontWeight: FontWeight.w400)].
  final TextStyle selectedTextStyle;

  /// The padding of the category name.
  /// Default value is [EdgeInsets.only(left: 8.0)].
  final EdgeInsetsGeometry textPadding;

  /// The overflow of the category name.
  /// Default value is [TextOverflow.ellipsis].
  final TextOverflow? textOverflow;

  /// Default text style of the category name.
  static const kDefaultTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  /// Creating an argument constructor of [OverlayCategorySettings] class.
  const OverlayCategorySettings({
    this.mouseCursorSelect = SystemMouseCursors.click,
    this.margin = const EdgeInsets.symmetric(horizontal: 4.0),
    this.constraints = const BoxConstraints(minHeight: 40),
    this.alignmentGeometry = Alignment.centerLeft,
    this.defaultDecoration = const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
    ),
    this.hoverDecoration = const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
    ),
    this.iconDefaultColor,
    this.iconSelectedColor,
    this.iconData = Icons.check,
    this.iconPadding = const EdgeInsets.only(left: 4, right: 3),
    // Its const.
    // ignore: no-magic-number
    this.iconSize = 16.0,
    this.iconAnimationDuration = const Duration(milliseconds: 400),
    this.iconAnimationCurve = Curves.easeInOutQuart,
    this.indent = const SizedBox(width: 25),
    this.showTooltip = true,
    this.defaultTextStyle = kDefaultTextStyle,
    this.selectedTextStyle = kDefaultTextStyle,
    this.textPadding = const EdgeInsets.only(left: 8.0),
    this.textOverflow = TextOverflow.ellipsis,
  });
}
