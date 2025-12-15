// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'package:basic_components/basic_components.dart';
import 'package:flutter/material.dart';
import 'package:morf/morf.dart';

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> with Morf {
  late final InputController nameController;
  late final InputController searchController;
  late final SelectionController<String> fruitController;

  final fruits = ['Apple', 'Banana', 'Coconut'];

  @override
  void initState() {
    super.initState();
    nameController = InputController(
      this,
      tag: 'name',
      label: 'Name',
      validators: {
        (value) {
          if (value == 'basic') return null;
          return 'Value must be basic\nnew line';
        },
      },
    );

    searchController = InputController(
      this,
      tag: 'search',
      label: 'Search',
    );

    fruitController = SelectionController(
      this,
      tag: 'fruit',
      label: 'Fruit',
    )..items = fruits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form fields'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          BasicTextField(
            controller: nameController,
            decoration: const InputDecoration(helperText: 'This is helper text'),
          ),
          const SizedBox(height: 16),
          BasicSearchField(
            controller: searchController,
          ),
          const SizedBox(height: 16),
          BasicDropDown<String>(
            controller: fruitController,
            itemBuilder: (item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            },
          ),
          const SizedBox(height: 48),
          BasicButton.filled(
            onPressed: () {
              print(validate());
            },
            label: 'Submit',
            size: const Size(double.infinity, 56),
          ),
        ],
      ),
    );
  }
}
