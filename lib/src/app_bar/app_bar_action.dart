// Copyright (c) 2025 EShare Authors. All rights reserved.

import 'package:flutter/material.dart';

class AppBarAction {
  const AppBarAction({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.fill = false,
  }) : child = null;

  const AppBarAction.custom({
    required this.child,
    required this.tooltip,
  }) : icon = null,
       fill = false,
       onPressed = null;

  final IconData? icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool fill;
  final Widget? child;
}
