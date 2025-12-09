// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'package:basic_components/src/slidable/slidable_controller.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

typedef OptionsBuilder = List<PreferredSizeWidget> Function(SlidableController);

// TODO (All) Pass controller from outside
class SlidableMenu extends StatefulWidget {
  const SlidableMenu({
    super.key,
    required this.optionsBuilder,
    required this.child,
    this.borderRadius,
    this.onSlideStart,
  });

  final Widget child;
  final OptionsBuilder optionsBuilder;
  final BorderRadius? borderRadius;
  final VoidCallback? onSlideStart;

  @override
  State<SlidableMenu> createState() => _SlidableMenuState();
}

class _SlidableMenuState extends State<SlidableMenu> with SingleTickerProviderStateMixin {
  final ValueNotifier<double> dragDistanceNotifier = ValueNotifier(0);
  late final ValueNotifier<Animation<double>> animationNotifier;
  late final AnimationController animationController;
  late final double maxRevealDistance;
  late final SlidableController slidableController;
  bool open = true;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        dragDistanceNotifier.value = animationNotifier.value.value;
      });
    slidableController = SlidableController(
      controller: animationController,
      onUpdateAnimation: ({required close}) {
        /// [open] is deciding if menu should open or not based on drag direction
        /// [close] is deciding if menu should always close without considering the drag direction
        animationNotifier.value = _getAnimation(open: !close && open);
      },
    );
    maxRevealDistance = _getMaxRevealDistance;
    animationNotifier = ValueNotifier(_getAnimation(open: open));
  }

  @override
  void dispose() {
    dragDistanceNotifier.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menu = GestureDetector(
      // Set [HitTestBehavior.translucent] to make gestures work on empty spaces
      behavior: HitTestBehavior.translucent,
      onHorizontalDragDown: (_) {
        widget.onSlideStart?.call();
        animationController.stop();
      },
      onHorizontalDragUpdate: (details) {
        open = details.delta.dx < 0;
        dragDistanceNotifier.value += details.delta.dx;
        if (dragDistanceNotifier.value > 0) dragDistanceNotifier.value = 0;
        if (dragDistanceNotifier.value < -maxRevealDistance) dragDistanceNotifier.value = -maxRevealDistance;
      },
      onHorizontalDragEnd: (_) => slidableController.toggle(),
      child: ValueListenableBuilder(
        valueListenable: dragDistanceNotifier,
        builder: (context, double dx, child) {
          return Stack(
            fit: StackFit.loose,
            children: [
              // A redundant child was added with 0 opacity so that stack
              // could properly wrap itself around the child
              // If this child was not present then the stack would expand unconstrained
              Opacity(opacity: 0, child: child),
              Positioned.fill(left: dx, right: dx.abs(), child: child!),
              Positioned.fill(
                right: dx.abs() - maxRevealDistance,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: widget.optionsBuilder(slidableController)),
              ),
            ],
          );
        },
        child: widget.child,
      ),
    );
    if (widget.borderRadius.isNull) return menu;
    return Material(color: Colors.transparent, clipBehavior: Clip.antiAlias, borderRadius: widget.borderRadius, child: menu);
  }

  double get _getMaxRevealDistance {
    return widget.optionsBuilder(slidableController).fold(0, (value, element) {
      return value + element.preferredSize.width;
    });
  }

  Animation<double> _getAnimation({bool open = true}) {
    return Tween<double>(
      begin: dragDistanceNotifier.value,
      end: open ? -maxRevealDistance : 0,
    ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut, reverseCurve: Curves.easeIn));
  }
}
