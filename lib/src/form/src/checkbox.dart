// Copyright (c) 2055 Order of Runes Authors. All rights reserved.

import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class BasicCheckbox extends StatefulWidget {
  const BasicCheckbox({
    super.key,
    required this.isChecked,
    this.activeColor,
    this.checkColor,
    required this.onChanged,
    this.label,
  });

  /// Whether the checkbox is checked or not.
  final bool isChecked;

  /// The color of the checkbox when it is active.
  final Color? activeColor;

  /// The color that fills checkbox
  final Color? checkColor;

  /// The label is the name of the checkbox that is by right to checkbox
  final String? label;

  final ValueChanged<bool> onChanged;

  @override
  State<BasicCheckbox> createState() => _BasicCheckboxState();
}

class _BasicCheckboxState extends State<BasicCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked; // Initialize the internal state from the parent
  }

  @override
  Widget build(BuildContext context) {
    final checkbox = Checkbox(
      value: _isChecked,
      activeColor: widget.activeColor,
      checkColor: widget.checkColor,
      onChanged: (value) {
        setState(() {
          _isChecked = value!;
          widget.onChanged(_isChecked);
        });
      },
    );

    if (widget.label.isNull) return checkbox;

    return Row(
      children: [
        checkbox,
        Expanded(child: Text(widget.label!)),
      ],
    );
  }
}
