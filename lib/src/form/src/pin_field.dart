// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morf/morf.dart';
import 'package:utils/utils.dart';

// TODO (Ishwor) Enable long press to paste code
// TODO (Ishwor) Add auto fill from sms
class BasicPinField extends StatefulWidget {
  const BasicPinField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.obscuringCharacter = '*',
    this.inputType = TextInputType.number,
    this.length = 5,
    this.inputFormatters,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final InputController controller;
  final TextInputType inputType;
  final bool obscureText;
  final String obscuringCharacter;
  final List<TextInputFormatter>? inputFormatters;
  final int length;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  State<BasicPinField> createState() => _BasicPinFieldState();
}

class _BasicPinFieldState extends State<BasicPinField> {
  late TextEditingController controller;
  late FocusNode node;
  int currentPosition = -1;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    node = FocusNode();
    controller.addListener(() {
      setState(() {
        final maxPosition = widget.length - 1;
        final length = controller.text.length;
        currentPosition = length > maxPosition ? maxPosition : length;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final color = theme.colorScheme;
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final hasError = widget.controller.error.isNotNullAndNotEmpty;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < widget.length; i++) ...[
                  Flexible(
                    child: Padding(
                      padding: i == widget.length - 1
                          ? EdgeInsets.zero
                          : const EdgeInsets.only(
                              right: 12,
                            ),
                      child: _UnitField(
                        value: _valueAtPosition(i),
                        size: 48,
                        state: hasError
                            ? _UnitFieldState.error
                            : currentPosition == i
                            ? _UnitFieldState.focused
                            : _UnitFieldState.unfocused,
                        obscuringCharacter: widget.obscureText ? widget.obscuringCharacter : null,
                        onFocused: () {
                          node.requestFocus();
                          setState(() => currentPosition = i);
                        },
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  widget.controller.error!,
                  style: textTheme.bodySmall!.copyWith(
                    color: color.error,
                  ),
                ),
              ),
            Offstage(
              child: TextField(
                controller: controller,
                onChanged: widget.controller.onChanged,
                focusNode: node,
                maxLength: widget.length,
                keyboardType: widget.inputType,
                inputFormatters: widget.inputFormatters,
                autofillHints: const [AutofillHints.oneTimeCode],
              ),
            ),
          ],
        );
      },
    );
  }

  String? _valueAtPosition(int position) {
    final text = controller.text;
    final length = text.length;
    if (currentPosition < 0 || text.isEmpty || (length - 1) < position) return null;

    return text[position];
  }
}

class _UnitField extends StatelessWidget {
  const _UnitField({
    required this.value,
    required this.size,
    required this.state,
    required this.onFocused,
    required this.obscuringCharacter,
  });

  final double size;
  final _UnitFieldState state;
  final String? value;
  final VoidCallback onFocused;
  final String? obscuringCharacter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final color = switch (state) {
      _UnitFieldState.focused => colorScheme.primaryContainer,
      _UnitFieldState.unfocused => colorScheme.outline,
      _UnitFieldState.error => colorScheme.error,
    };
    return GestureDetector(
      onTap: onFocused,
      child: SizedBox.fromSize(
        size: Size.square(size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color),
          ),
          child: value.isNull
              ? null
              : Center(
                  child: Text(
                    obscuringCharacter ?? value!,
                    style: textTheme.bodyLarge,
                  ),
                ),
        ),
      ),
    );
  }
}

enum _UnitFieldState { focused, unfocused, error }
