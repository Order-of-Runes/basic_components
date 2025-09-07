// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'package:flutter/material.dart';
import 'package:morf/morf.dart';
import 'package:utils/utils.dart';

mixin DecorMixin {
  InputDecoration getDecoration(BuildContext context, BaseController controller) {
    return InputDecoration(
      labelText: controller.label,
      hintText: controller.hint,
      helperText: controller.helper,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 16,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
  }

  InputDecoration mergeDecoration(InputDecoration defaultDecoration, InputDecoration newDecoration) {
    return defaultDecoration.copyWith(
      icon: newDecoration.icon,
      iconColor: newDecoration.iconColor,
      label: newDecoration.label,
      labelText: newDecoration.labelText,
      labelStyle: newDecoration.labelStyle,
      floatingLabelStyle: newDecoration.floatingLabelStyle,
      helperText: newDecoration.helperText,
      helperStyle: newDecoration.helperStyle,
      helperMaxLines: newDecoration.helperMaxLines,
      hintText: newDecoration.hintText,
      hintStyle: newDecoration.hintStyle,
      hintTextDirection: newDecoration.hintTextDirection,
      hintMaxLines: newDecoration.hintMaxLines,
      errorText: newDecoration.errorText,
      errorStyle: newDecoration.errorStyle,
      errorMaxLines: newDecoration.errorMaxLines,
      floatingLabelBehavior: newDecoration.floatingLabelBehavior,
      floatingLabelAlignment: newDecoration.floatingLabelAlignment,
      isCollapsed: newDecoration.isCollapsed,
      isDense: newDecoration.isDense,
      contentPadding: newDecoration.contentPadding,
      prefixIcon: newDecoration.prefixIcon,
      prefixIconConstraints: newDecoration.prefixIconConstraints,
      prefix: newDecoration.prefix,
      prefixText: newDecoration.prefixText,
      prefixStyle: newDecoration.prefixStyle,
      prefixIconColor: newDecoration.prefixIconColor,
      suffixIcon: newDecoration.suffixIcon,
      suffix: newDecoration.suffix,
      suffixText: newDecoration.suffixText,
      suffixStyle: newDecoration.suffixStyle,
      suffixIconColor: newDecoration.suffixIconColor,
      suffixIconConstraints: newDecoration.suffixIconConstraints,
      counter: newDecoration.counter,
      counterText: newDecoration.counterText,
      counterStyle: newDecoration.counterStyle,
      filled: newDecoration.filled,
      fillColor: newDecoration.fillColor,
      focusColor: newDecoration.focusColor,
      hoverColor: newDecoration.hoverColor,
      errorBorder: newDecoration.errorBorder,
      focusedBorder: newDecoration.focusedBorder,
      focusedErrorBorder: newDecoration.focusedErrorBorder,
      disabledBorder: newDecoration.disabledBorder,
      enabledBorder: newDecoration.enabledBorder,
      border: newDecoration.border,
      enabled: newDecoration.enabled,
      semanticCounterText: newDecoration.semanticCounterText,
      alignLabelWithHint: newDecoration.alignLabelWithHint,
      constraints: newDecoration.constraints,
    );
  }

  InputDecoration resolveDecoration(
    InputDecoration decoration, {
    required Widget? prefixIcon,
    required Widget? suffixIcon,
    required String? errorText,
  }) {
    if (prefixIcon.isNull && suffixIcon.isNull && errorText.isNull) return decoration;

    return decoration.copyWith(prefixIcon: prefixIcon, suffixIcon: suffixIcon, errorText: errorText);
  }
}
