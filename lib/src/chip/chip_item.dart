// Copyright (c) 2025 EShare Authors. All rights reserved.
// ignore_for_file: avoid_positional_boolean_parameters

import 'package:basic_components/src/chip/chip_action.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class ChipItem<T> extends Equatable {
  const ChipItem({
    required this.id,
    required this.label,
    required this.value,
    this.onAction,
    this.isSelected = false,
    this.style,
    this.selectedStyle,
    this.leadingWidgetBuilder,
    this.color,
    this.selectedColor,
    this.borderColor,
    this.selectedBorderColor,
    this.trailingIconColor,
    this.selectedTrailingIconColor,
  });

  final String id;
  final String label;
  final T? value;
  final bool isSelected;

  final TextStyle? style;
  final TextStyle? selectedStyle;

  final Color? color;
  final Color? selectedColor;
  final Color? borderColor;
  final Color? selectedBorderColor;
  final Color? trailingIconColor;
  final Color? selectedTrailingIconColor;

  final Widget Function(bool isSelected)? leadingWidgetBuilder;
  final void Function(ChipItem<T> chip, ChipAction<T>)? onAction;

  bool get hasAction => onAction.isNotNull;

  ChipItem<T> copyWith({
    String? label,
    T? Function()? onValue,
    bool? isSelected,
  }) {
    return ChipItem(
      id: id,
      label: label ?? this.label,
      value: onValue.isNull ? value : onValue!(),
      isSelected: isSelected ?? this.isSelected,
      style: style,
      selectedStyle: selectedStyle,
      leadingWidgetBuilder: leadingWidgetBuilder,
      color: color,
      selectedColor: selectedColor,
      trailingIconColor: trailingIconColor,
      selectedTrailingIconColor: selectedTrailingIconColor,
      onAction: onAction,
      borderColor: borderColor,
      selectedBorderColor: selectedBorderColor,
    );
  }

  @override
  List<Object?> get props => [
    id,
    label,
    value,
    isSelected,
    style,
    selectedStyle,
    color,
    selectedColor,
    trailingIconColor,
    selectedTrailingIconColor,
    onAction,
    borderColor,
    selectedBorderColor,
  ];

  @override
  String toString() {
    return '''
ChipItem<$T>{
  id: $id,
  label: $label,
  value: $value,
  isSelected: $isSelected
}
    ''';
  }
}
