import 'package:flutter/foundation.dart';

enum SelectMode {
  modal,
  overlay,
  auto;

  bool get isModal =>
      this == SelectMode.modal ||
      (this == SelectMode.auto && defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);
}
