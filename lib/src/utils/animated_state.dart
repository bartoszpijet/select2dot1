import 'package:flutter/material.dart';
import 'package:select2dot1/src/select2dot1_widget.dart';

abstract class AnimatedState<T> extends State<Select2dot1<T>>
    with TickerProviderStateMixin {
  // Its good :D.
  // ignore: avoid-late-keyword
  late final AnimationController _animationController;

  AnimationController get getAnimationController => _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget
          .selectStyle.overlayStyle.dropdownOverlaySettings.animationDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
}
