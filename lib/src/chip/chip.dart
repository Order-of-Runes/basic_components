// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'package:basic_components/src/chip/chip_item.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class BasicChip<T> extends StatelessWidget {
  const BasicChip({
    super.key,
    required this.item,
    required this.onTap,
    this.radius = 8,
  });

  final ChipItem<T> item;
  final VoidCallback onTap;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final chipStyle = _getChipStyle(context);
    final borderRadius = BorderRadius.circular(radius);

    final labelWidget = Text(item.label, style: chipStyle.style);
    final leadingWidget = item.leadingWidgetBuilder?.call(item.isSelected);
    final child = item.hasAction || leadingWidget.isNotNull
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingWidget.isNotNull)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: leadingWidget!,
                ),
              labelWidget,
              if (item.hasAction)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: chipStyle.iconColor,
                    size: 16,
                  ),
                ),
            ],
          )
        : labelWidget;

    return InkWell(
      borderRadius: borderRadius,
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
            color: chipStyle.borderColor,
          ),
          color: chipStyle.color,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            leadingWidget.isNull ? 16 : 8,
            8,
            item.hasAction ? 8 : 16,
            8,
          ),
          child: child,
        ),
      ),
    );
  }

  _ChipStyle _getChipStyle(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final textTheme = theme.textTheme;
    return item.isSelected
        ? _ChipStyle(
            color: item.selectedColor ?? color.primary,
            borderColor: item.borderColor ?? color.primary,
            style: item.selectedStyle ?? textTheme.labelMedium!,
            iconColor: item.selectedTrailingIconColor ?? color.onPrimaryContainer,
          )
        : _ChipStyle(
            color: item.color ?? Colors.transparent,
            borderColor: item.selectedBorderColor ?? color.onSurfaceVariant,
            style: item.style ?? textTheme.labelMedium!,
            iconColor: item.trailingIconColor ?? color.onSurfaceVariant,
          );
  }
}

class _ChipStyle {
  _ChipStyle({
    required this.style,
    required this.color,
    required this.iconColor,
    required this.borderColor,
  });

  final TextStyle style;
  final Color color;
  final Color iconColor;
  final Color borderColor;
}
