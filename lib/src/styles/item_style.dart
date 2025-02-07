import 'package:flutter/material.dart';

/// This is a class which contains all the settings of the category item of list data view in overlay mode.
class ItemStyle {
  /// The margin of the category item.
  /// Default value is [EdgeInsets.symmetric(horizontal: 4.0)].
  final EdgeInsetsGeometry? margin;

  /// The decoration of the category item.
  /// Default value is [BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)))].
  final ButtonStyle? buttonStyle;

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
  /// Default is 25.
  final double indent;

  /// Will be showing tooltip.
  /// Default it is true.
  final bool showTooltip;

  /// The text overflow of the text.
  /// Default value is [TextOverflow.ellipsis].
  final TextOverflow? textOverflow;

  /// The default text style.
  static const _kDefaultTextStyle = TextStyle(
    fontSize: _fontSize,
    fontWeight: FontWeight.w400,
  );

  static const double _fontSize = 16;

  static const ButtonStyle defaultItemButonStyle = ButtonStyle(
    alignment: Alignment.centerLeft,
    textStyle: WidgetStatePropertyAll(_kDefaultTextStyle),
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
    iconSize: WidgetStatePropertyAll(_fontSize),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    ),
  );

  /// Creating an argument constructor of [ItemStyle] class.
  const ItemStyle({
    this.margin = const EdgeInsets.symmetric(horizontal: 4.0),
    this.buttonStyle,
    this.iconData = Icons.check,
    this.iconPadding = const EdgeInsets.only(left: 4, right: 3),
    this.iconAnimationDuration = const Duration(milliseconds: 400),
    this.iconAnimationCurve = Curves.easeInOutQuart,
    // Its const.
    // ignore: no-magic-number
    this.indent = 25,
    this.showTooltip = true,
    this.textOverflow = TextOverflow.ellipsis,
  });
}
