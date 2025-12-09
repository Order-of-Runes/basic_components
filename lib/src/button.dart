// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class BasicButton extends StatelessWidget {
  const BasicButton._({
    super.key,
    required ButtonType type,
    required this.onPressed,
    required this.label,
    required this.size,
    required this.capitalize,
    required this.mini,
    this.icon,
    this.iconAlignment,
    this.textStyle,
    this.buttonColor,
    this.borderRadius,
    this.isEnabled = true,
  }) : _type = type;

  factory BasicButton.elevated({
    Key? key,
    required VoidCallback onPressed,
    required String label,
    required Size size,
    bool capitalize = false,
    bool mini = false,
    Widget? icon,
    IconAlignment? iconAlignment,
    TextStyle? textStyle,
    Color? buttonColor,
    double? borderRadius,
    bool isEnabled = true,
  }) {
    return BasicButton._(
      key: key,
      type: ButtonType.elevated,
      onPressed: onPressed,
      mini: mini,
      icon: icon,
      iconAlignment: iconAlignment,
      size: size,
      label: label,
      textStyle: textStyle,
      capitalize: capitalize,
      buttonColor: buttonColor,
      borderRadius: borderRadius,
      isEnabled: isEnabled,
    );
  }

  factory BasicButton.filled({
    Key? key,
    required VoidCallback onPressed,
    required String label,
    required Size size,
    bool capitalize = false,
    bool mini = false,
    Widget? icon,
    IconAlignment? iconAlignment,
    TextStyle? textStyle,
    Color? buttonColor,
    double? borderRadius,
    bool isEnabled = true,
  }) {
    return BasicButton._(
      key: key,
      type: ButtonType.filled,
      onPressed: onPressed,
      icon: icon,
      mini: mini,
      iconAlignment: iconAlignment,
      size: size,
      label: label,
      textStyle: textStyle,
      capitalize: capitalize,
      buttonColor: buttonColor,
      borderRadius: borderRadius,
      isEnabled: isEnabled,
    );
  }

  factory BasicButton.outlined({
    Key? key,
    required VoidCallback onPressed,
    required String label,
    required Size size,
    bool capitalize = false,
    bool mini = false,
    Widget? icon,
    IconAlignment? iconAlignment,
    TextStyle? textStyle,
    Color? buttonColor,
    double? borderRadius,
    bool isEnabled = true,
  }) {
    return BasicButton._(
      key: key,
      type: ButtonType.outlined,
      mini: mini,
      onPressed: onPressed,
      icon: icon,
      iconAlignment: iconAlignment,
      size: size,
      label: label,
      textStyle: textStyle,
      capitalize: capitalize,
      buttonColor: buttonColor,
      borderRadius: borderRadius,
      isEnabled: isEnabled,
    );
  }

  factory BasicButton.text({
    Key? key,
    required VoidCallback onPressed,
    required String label,
    required Size size,
    bool capitalize = false,
    bool mini = false,
    Widget? icon,
    IconAlignment? iconAlignment,
    TextStyle? textStyle,
    double? borderRadius,
    bool isEnabled = true,
  }) {
    return BasicButton._(
      key: key,
      type: ButtonType.text,
      onPressed: onPressed,
      icon: icon,
      iconAlignment: iconAlignment,
      size: size,
      label: label,
      textStyle: textStyle,
      capitalize: capitalize,
      borderRadius: borderRadius,
      isEnabled: isEnabled,
      mini: mini,
    );
  }

  /// Button text
  final String label;

  /// Action callback
  final VoidCallback onPressed;

  /// Should capitalize button text
  final bool capitalize;

  /// Size of the button
  final Size size;

  /// Icon alignment
  final IconAlignment? iconAlignment;

  /// Button color
  final Color? buttonColor;

  /// Text style for button text
  final TextStyle? textStyle;

  /// Button icon
  final Widget? icon;

  /// Button border radius
  final double? borderRadius;

  final ButtonType _type;

  /// Button enable
  final bool isEnabled;

  final bool mini;

  ButtonType get type => _type;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(capitalize ? label.toUpperCase() : label, maxLines: 1, overflow: TextOverflow.ellipsis, style: textStyle);

    final borderShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? size.height / 2),
    );
    final padding = mini ? const EdgeInsets.symmetric(horizontal: 12, vertical: 0) : null;
    switch (_type) {
      case ButtonType.elevated:
        final style = ElevatedButton.styleFrom(
          shape: borderShape,
          backgroundColor: buttonColor,
          minimumSize: size,
          padding: padding,
          elevation: 2,
        );
        if (icon.isNull) {
          return ElevatedButton(
            style: style,
            onPressed: isEnabled ? onPressed : null,
            child: textWidget,
          );
        }
        return ElevatedButton.icon(
          onPressed: isEnabled ? onPressed : null,
          style: style,
          icon: icon,
          iconAlignment: iconAlignment ?? IconAlignment.start,
          label: textWidget,
        );
      case ButtonType.filled:
        final style = FilledButton.styleFrom(
          backgroundColor: buttonColor,
          shape: borderShape,
          minimumSize: size,
          padding: padding,
        );

        if (icon.isNull) {
          return FilledButton(
            style: style,
            onPressed: isEnabled ? onPressed : null,
            child: textWidget,
          );
        }
        return FilledButton.icon(
          onPressed: isEnabled ? onPressed : null,
          style: style,
          icon: icon,
          iconAlignment: iconAlignment ?? IconAlignment.start,
          label: textWidget,
        );
      case ButtonType.outlined:
        final style = OutlinedButton.styleFrom(
          side: buttonColor.isNull ? null : BorderSide(color: buttonColor!),
          shape: borderShape,
          minimumSize: size,
          padding: padding,
        );

        if (icon.isNull) {
          return OutlinedButton(
            style: style,
            onPressed: isEnabled ? onPressed : null,
            child: textWidget,
          );
        }
        return OutlinedButton.icon(
          onPressed: isEnabled ? onPressed : null,
          style: style,
          icon: icon,
          iconAlignment: iconAlignment ?? IconAlignment.start,
          label: textWidget,
        );
      case ButtonType.text:
        final style = TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: mini
                ? padding?.left ?? 12
                : icon.isNull
                ? 24
                : 16,
          ),
          shape: borderShape,
          minimumSize: size,
        );

        if (icon.isNull) {
          return TextButton(style: style, onPressed: isEnabled ? onPressed : null, child: textWidget);
        }
        return TextButton.icon(
          onPressed: isEnabled ? onPressed : null,
          style: style,
          icon: icon,
          iconAlignment: iconAlignment ?? IconAlignment.start,
          label: textWidget,
        );
    }
  }
}

enum ButtonType { elevated, filled, text, outlined }
