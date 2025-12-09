// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'dart:async';

import 'package:basic_components/src/chip/chip.dart';
import 'package:basic_components/src/chip/chip_action.dart';
import 'package:basic_components/src/chip/chip_item.dart';
import 'package:better_components/better_components.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class ChipSet<T> extends StatelessWidget {
  const ChipSet({
    super.key,
    required this.items,
    required ValueChanged<T?> onSelected,
    this.labelStyle,
    this.gap = 12,
    this.height = 32,
    this.padding,
  }) : _onSelected = onSelected,
       _onMultiSelected = null;

  const ChipSet.multi({
    super.key,
    required this.items,
    required ValueChanged<Map<String, T>> onSelected,
    this.labelStyle,
    this.gap = 12,
    this.height = 32,
    this.padding,
  }) : _onMultiSelected = onSelected,
       _onSelected = null;

  final List<ChipItem<T>> items;

  final TextStyle? labelStyle;
  final double gap;
  final double height;
  final EdgeInsets? padding;

  final ValueChanged<T?>? _onSelected;
  final ValueChanged<Map<String, T>>? _onMultiSelected;

  @override
  Widget build(BuildContext context) {
    assert(_onSelected.isNotNull || _onMultiSelected.isNotNull);

    final canSelectMultiple = _onMultiSelected.isNotNull;

    return _ChipList(
      items: items,
      onSelected: (map) {
        if (canSelectMultiple) {
          _onMultiSelected?.call(map);
        }

        _onSelected?.call(map.values.isNotEmpty ? map.values.first : null);
      },
      labelStyle: labelStyle,
      isMultiSelect: canSelectMultiple,
      gap: gap,
      height: height,
      padding: padding ?? EdgeInsets.zero,
    );
  }
}

class _ChipList<T> extends StatefulWidget {
  const _ChipList({
    required this.items,
    required this.onSelected,
    required this.labelStyle,
    required this.isMultiSelect,
    required this.gap,
    required this.height,
    required this.padding,
  });

  final List<ChipItem<T>> items;
  final ValueChanged<Map<String, T>> onSelected;
  final TextStyle? labelStyle;
  final bool isMultiSelect;
  final double gap;
  final double height;
  final EdgeInsets padding;

  @override
  State<_ChipList<T>> createState() => _ChipListState<T>();
}

class _ChipListState<T> extends State<_ChipList<T>> {
  late final Map<String, ChipItem<T>> _chipMap;
  late final List<ChipItem<T>> _chips;

  @override
  void initState() {
    super.initState();
    _chips = List.of(widget.items);
    _chipMap = {
      for (final chip in _chips) chip.id: chip,
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.separated(
        padding: widget.padding,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = _chips[index];
          return BasicChip(
            item: item,
            onTap: () => _handleOnTap(item),
          );
        },
        separatorBuilder: (context, index) {
          return HorizontalGap(widget.gap);
        },
        itemCount: _chips.length,
      ),
    );
  }

  Future<void> _handleOnTap(ChipItem<T> item) async {
    // Update the state of tapped chip
    final ChipItem<T> affectedChip = await _computeChip(item);

    // Use the affectedChip and update the existing list and fetch their corresponding values
    final (updatedChips, values) = _getUpdatedChipsAndValues(affectedChip);

    setState(() {
      _chips
        ..clear()
        ..addAll(updatedChips);

      widget.onSelected(values);
    });
  }

  Future<ChipItem<T>> _computeChip(ChipItem<T> originalChip) async {
    if (!originalChip.hasAction) {
      return originalChip.copyWith(
        isSelected: !originalChip.isSelected,
      );
    }

    final Completer<ChipItem<T>> completer = Completer();
    originalChip.onAction?.call(originalChip, ChipAction(completer));

    final updatedChip = await completer.future;
    return updatedChip.copyWith(isSelected: updatedChip.value.isNotNull);
  }

  (List<ChipItem<T>>, Map<String, T>) _getUpdatedChipsAndValues(ChipItem<T> affectedChip) {
    final values = <String, T>{};
    final updatedChips = <ChipItem<T>>[];
    for (final chip in _chips) {
      final isAffected = affectedChip.id == chip.id;
      if (widget.isMultiSelect) {
        final updatedChip = isAffected ? affectedChip : chip;
        updatedChips.add(updatedChip);
        if (updatedChip.isSelected && updatedChip.value.isNotNull) {
          values[updatedChip.id] = updatedChip.value!;
        }
      } else {
        updatedChips.add(
          isAffected
              ? affectedChip
              : chip.isSelected
              ? chip.copyWith(
                  isSelected: false,
                  onValue: chip.hasAction ? () => null : null,
                  label: _chipMap[chip.id]?.label ?? '',
                )
              : chip,
        );

        if (values.isEmpty && affectedChip.isSelected && affectedChip.value.isNotNull) {
          values[affectedChip.id] = affectedChip.value!;
        }
      }
    }

    return (updatedChips, values);
  }
}
