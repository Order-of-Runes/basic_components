// Copyright (c) 2025 Order of Runes Authors. All rights reserved.

import 'package:basic_components/basic_components.dart';
import 'package:flutter/material.dart';

class BasicAppBarExample extends StatelessWidget {
  const BasicAppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (_, __) {
            return [
              BasicAppBar(
                collapsed: false,
                pinned: true,
                appBarHeight: 64,
                flexibleTop: PreferredSize(
                  preferredSize: const Size.fromHeight(84),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'SOME TITLE',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Description for the above text and the text goes on and on',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        radius: 21,
                      ),
                    ],
                  ),
                ),
                collapsedBuilder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'SOME TITLE',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '1,175.10 ',
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '20.25',
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600, color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  );
                },
                actions: [
                  AppBarAction(
                    icon: Icons.star,
                    tooltip: 'Test',
                    onPressed: () {},
                  ),
                ],
              ),
            ];
          },
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: List.generate(100, (index) => index, growable: false)
                .map((v) {
                  return Text(
                    v.toString(),
                    style: Theme.of(context).textTheme.displaySmall,
                  );
                })
                .toList(growable: false),
          ),
        ),
      ),
    );
  }
}
