// Copyright (c) 2025 EShare Authors. All rights reserved.

import 'package:basic_components/src/gaps.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class DialogBase extends StatelessWidget {
  const DialogBase({
    super.key,
    required this.actions,
    this.header,
    this.title,
    this.body,
    this.contentPadding,
    this.headerHeight = 100,
  });

  final List<Widget> actions;
  final Widget? header;
  final Widget? title;
  final Widget? body;
  final EdgeInsets? contentPadding;
  final double headerHeight;

  @override
  Widget build(BuildContext context) {
    if (header.isNull && title.isNull && body.isNull) {
      return Dialog(
        child: SizedBox(
          width: double.infinity,
          child: Wrap(children: actions),
        ),
      );
    }

    return Dialog(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (header.isNotNull)
              SizedBox(
                height: headerHeight,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                  child: header!,
                ),
              ),
            Padding(
              padding: contentPadding ?? const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title.isNotNull) title!,
                  if (title.isNotNull && body.isNotNull) const VerticalGap(),
                  if (body.isNotNull) SingleChildScrollView(child: body!),
                ],
              ),
            ),
            if (actions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 24, 24),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: actions,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
