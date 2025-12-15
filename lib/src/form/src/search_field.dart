// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'package:basic_components/src/form/src/helper/decor_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morf/morf.dart';
import 'package:utils/utils.dart';

class BasicSearchField extends StatefulWidget {
  const BasicSearchField({
    super.key,
    required this.controller,
    this.inputFormatters,
    this.inputType,
    this.prefixIcon,
    this.suffixIcon = const Icon(Icons.search),
    this.autofillHints = const [],
    this.height,
    this.contentPadding,
  });

  final InputController controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? inputType;
  final Widget? prefixIcon;
  final Widget suffixIcon;
  final List<String> autofillHints;

  final double? height;
  final EdgeInsets? contentPadding;

  @override
  State<BasicSearchField> createState() => _BasicSearchFieldState();
}

class _BasicSearchFieldState extends State<BasicSearchField> with DecorMixin {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    if (widget.controller.value.isNotNullAndNotEmpty) {
      _textEditingController.text = widget.controller.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final defaultDecoration = getDecoration(
          context,
          widget.controller,
          widget.height,
          widget.contentPadding,
          hasPrefixIcon: widget.prefixIcon.isNotNull,
          hasSuffixIcon: widget.suffixIcon.isNotNull,
        );
        final mergedDecoration = mergeDecoration(
          defaultDecoration,
          InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainer,
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIconColor: Theme.of(context).colorScheme.onSurfaceVariant,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        );

        return TextField(
          controller: _textEditingController,
          onChanged: widget.controller.onChanged,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.inputType,
          autofillHints: widget.autofillHints,
          decoration: resolveDecoration(
            mergedDecoration,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            errorText: widget.controller.error,
          ),
        );
      },
    );
  }
}
