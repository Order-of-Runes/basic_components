// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'package:basic_components/src/form/src/helper/decor_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morf/morf.dart';
import 'package:utils/utils.dart';

class BasicTextField extends StatefulWidget {
  const BasicTextField({
    super.key,
    required this.controller,
    this.decoration,
    this.inputFormatters,
    this.obscureText = false,
    this.obscuringCharacter = '*',
    this.inputType,
    this.prefixIcon,
    this.suffixIcon,
    this.autofillHints = const [],
    this.onTap,
    this.readOnly = false,
    this.requestFocus = false,
    this.enabled,
    this.textInputAction,
    this.height,
    this.contentPadding,
  });

  final InputController controller;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;
  final TextInputType? inputType;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<String> autofillHints;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool requestFocus;
  final bool? enabled;
  final TextInputAction? textInputAction;

  final double? height;
  final EdgeInsets? contentPadding;

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> with DecorMixin {
  late TextEditingController _textEditingController;
  late FocusNode? node;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.text = widget.controller.value ?? '';
    if (widget.requestFocus) {
      node = FocusNode();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        node!.requestFocus();
      });
    } else {
      node = null;
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        _textEditingController.text = widget.controller.value ?? '';
        final defaultDecoration = getDecoration(
          context,
          widget.controller,
          widget.height,
          widget.contentPadding,
          hasPrefixIcon: widget.prefixIcon.isNotNull,
          hasSuffixIcon: widget.suffixIcon.isNotNull,
        );
        final mergedDecoration = widget.decoration.isNull
            ? defaultDecoration
            : mergeDecoration(
                defaultDecoration,
                widget.decoration!,
              );

        return TextField(
          focusNode: node,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          controller: _textEditingController,
          onChanged: widget.controller.onChanged,
          obscureText: widget.obscureText,
          obscuringCharacter: widget.obscuringCharacter,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.inputType,
          autofillHints: widget.autofillHints,
          onTap: widget.onTap,
          textInputAction: widget.textInputAction,
          onSubmitted: widget.controller.onSubmitted,
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
