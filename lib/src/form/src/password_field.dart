// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'package:basic_components/src/form/src/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morf/morf.dart';

class BasicPasswordField extends StatefulWidget {
  const BasicPasswordField({
    super.key,
    required this.controller,
    this.decoration,
    this.inputFormatters,
    this.inputType,
    this.textInputAction,
    this.requestFocus = false,
  });

  final InputController controller;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final bool requestFocus;

  @override
  State<BasicPasswordField> createState() => _BasicPasswordFieldState();
}

class _BasicPasswordFieldState extends State<BasicPasswordField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return BasicTextField(
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      requestFocus: widget.requestFocus,
      decoration: widget.decoration,
      inputFormatters: widget.inputFormatters,
      inputType: widget.inputType,
      autofillHints: const [AutofillHints.password],
      obscureText: obscureText,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        icon: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
          fill: 1,
        ),
      ),
    );
  }
}
