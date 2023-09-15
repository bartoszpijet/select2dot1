import 'dart:async';

import 'package:flutter/material.dart';
import 'package:select2dot1/src/utils/animated_state.dart';

mixin OverlayController<T> on AnimatedState<T> {
  // It has to be late.
  // ignore: avoid-late-keyword
  final OverlayPortalController overlayController = OverlayPortalController();

  ValueNotifier<bool> get getIsVisibleOvarlay =>
      ValueNotifier<bool>(overlayController.isShowing);

  void toogleOverlay() {
    if (overlayController.isShowing) {
      hideOverlay();
    } else {
      showOverlay();
    }
  }

  void showOverlay() {
    overlayController.show();
    // Not needed.
    // ignore:avoid-ignoring-return-values
    getAnimationController.forward();
  }

  void hideOverlay() {
    unawaited(
      getAnimationController.reverse().then((_) => overlayController.hide()),
    );
  }

  void refreshOverlayState(_) {
    // if (_overlay == null) {
    //   return;
    // }
    // // This can't be null, assert is above.
    // // ignore: avoid-non-null-assertion
    // if (_overlay!.mounted) {
    //   // Just refresh.
    //   // ignore: no-empty-block
    //   _overlay?.setState(() {});
    // }
  }
}
