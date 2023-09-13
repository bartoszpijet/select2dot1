import 'dart:async';

import 'package:flutter/material.dart';
import 'package:select2dot1/src/utils/animated_state.dart';

mixin OverlayController on AnimatedState {
  // It has to be late.
  // ignore: avoid-late-keyword
  final OverlayPortalController overlayController = OverlayPortalController();

  ValueNotifier<bool> get getIsVisibleOvarlay =>
      ValueNotifier<bool>(overlayController.isShowing);

  void toogleOverlay() {
    if (overlayController.isShowing) {
      unawaited(
        getAnimationController
            .reverse()
            .then((vak) => overlayController.hide()),
      );
    } else {
      overlayController.show();
      getAnimationController.forward();
    }
  }

  void showOverlay() {
    overlayController.show();
    getAnimationController.forward();
  }

  void hideOverlay() {
    unawaited(
      getAnimationController.reverse().then((vak) => overlayController.hide()),
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
