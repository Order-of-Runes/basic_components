// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'package:components_example/examples/app_bar.dart';
import 'package:flutter/material.dart';

class Components extends StatelessWidget {
  const Components();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic components'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(24),
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: [
          _Item(
            title: 'Appbar',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BasicAppBarExample()),
              );
            },
          ),
          _Item(
            title: 'Form fields',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BasicAppBarExample()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.3),
          borderRadius: borderRadius,
          border: Border.all(color: Colors.grey),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}
