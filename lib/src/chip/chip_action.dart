// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'dart:async';

import 'package:basic_components/src/chip/chip_item.dart';

class ChipAction<T> {
  ChipAction(this._completer);

  final Completer<ChipItem<T>> _completer;

  void select(ChipItem<T> value) {
    if (_completer.isCompleted) return;

    _completer.complete(value);
  }
}
