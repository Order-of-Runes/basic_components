// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'package:basic_components/src/form/src/helper/decor_mixin.dart';
import 'package:flutter/material.dart';
import 'package:morf/morf.dart';
import 'package:utils/utils.dart';

typedef DropDownItemBuilder<I> = DropdownMenuItem<I> Function(I);

class BasicDropDown<I extends Object> extends StatelessWidget {
  const BasicDropDown({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.decoration,
    this.prefixIcon,
    this.suffixIcon,
    this.enable = true,
    this.isExpanded = false,
    this.isDense = true,
    this.itemHeight,
    this.disabledHint,
    this.autofocus = false,
  });

  final SelectionController<I> controller;
  final DropDownItemBuilder<I> itemBuilder;
  final InputDecoration? decoration;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enable;
  final bool isExpanded;
  final bool isDense;
  final bool autofocus;
  final double? itemHeight;
  final Widget? disabledHint;

  @override
  Widget build(BuildContext context) {
    return BasicDropDownWithTransform(
      controller: controller,
      itemBuilder: itemBuilder,
      decoration: decoration,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enable: enable,
    );
  }
}

class BasicDropDownWithTransform<I extends Object, O extends Object> extends StatelessWidget with DecorMixin {
  const BasicDropDownWithTransform({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.decoration,
    this.prefixIcon,
    this.suffixIcon,
    this.enable = true,
    this.isExpanded = false,
    this.isDense = true,
    this.itemHeight,
    this.disabledHint,
    this.autofocus = false,
  });

  final TransformableSelectionController<I, O> controller;
  final DropDownItemBuilder<I> itemBuilder;
  final InputDecoration? decoration;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enable;
  final bool isExpanded;
  final bool isDense;
  final bool autofocus;
  final double? itemHeight;
  final Widget? disabledHint;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final defaultDecoration = getDecoration(context, controller);
        final mergedDecoration = decoration.isNull ? defaultDecoration : mergeDecoration(defaultDecoration, decoration!);
        return DropdownButtonFormField<I>(
          initialValue: controller.value,
          isExpanded: isExpanded,
          isDense: isDense,
          autofocus: autofocus,
          itemHeight: itemHeight,
          disabledHint: disabledHint,
          items: controller.items.map(itemBuilder).toList(),
          onChanged: enable ? controller.onChanged : null,
          decoration: resolveDecoration(
            mergedDecoration,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorText: controller.error,
          ),
        );
      },
    );
  }
}
