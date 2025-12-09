// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'package:flutter/animation.dart';

class SlidableController {
  final AnimationController controller;
  final void Function({required bool close}) onUpdateAnimation;

  SlidableController({required this.controller, required this.onUpdateAnimation});

  void toggle({bool close = false}) {
    onUpdateAnimation(close: close);
    controller
      ..reset()
      ..forward();
  }
}
