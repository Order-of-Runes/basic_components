// Copyright (c) 2025 EShare Authors. All rights reserved.

import 'package:basic_components/src/app_bar/app_bar_action.dart';
import 'package:basic_components/src/app_bar/flexible_space.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class BasicAppBar extends StatelessWidget {
  const BasicAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.flexibleTop,
    this.flexibleMid,
    this.flexibleBottom,
    this.bottom,
    this.flexibleSpace,
    this.padding,
    this.gap,
    this.pinBottom = true,
    this.snap = false,
    this.collapsed = false,
    this.pinned = false,
    this.actions = const [],
    this.titleSpacing = 0,
    this.appBarHeight = 56,
    this.titleHeight = 28,
    this.subtitleHeight = 20,
    this.actionOverflowThreshold = 2,
    this.collapsedBuilder,
  });

  /*
  Base AppBar
  Flexible top
  Title
  Flexible mid
  Subtitle
  Flexible bottom
  Bottom
  -----
  Or
  -----
  Base AppBar
  Flexible space
  */

  /// Title for appbar
  final Widget? title;

  /// Subtitle for appbar
  final Widget? subtitle;

  /// Custom widget to be placed above the [title]
  final PreferredSizeWidget? flexibleTop;

  /// Custom widget to be placed between the [title] & [subtitle]
  final PreferredSizeWidget? flexibleMid;

  /// Custom widget to be placed below the [subtitle]
  final PreferredSizeWidget? flexibleBottom;

  /// This is placed at the absolute bottom of the app bar
  ///
  /// Tab bar should be placed here
  ///
  /// This is a special widget, because it is not handled by the [BasicAppBar] itself
  /// but will be passed on the [TmsPage] for it's placement
  final PreferredSizeWidget? bottom;

  /// This will be placed inside SliverAppBar's [FlexibleSpace]
  ///
  /// This will override the  [title], [subtitle], [flexibleTop],
  /// [flexibleMid] & [flexibleBottom]
  final PreferredSizeWidget? flexibleSpace;

  /// Padding around the appbar
  final EdgeInsets? padding;

  /// Gap in between each components
  final double? gap;

  /// Should the bottom widget be pinned
  final bool pinBottom;

  /// If [snap] is true then the floating app bar will "snap"
  /// into view.
  final bool snap;

  /// If [pinned] is false then the app bar will scroll away
  /// when the user scrolls down
  final bool pinned;

  /// Should app bar be in collapsed mode or not
  ///
  /// If [collapsed] is true then [flexibleSpace], [subtitle] and [flexibleTop]
  /// will be ignored
  final bool collapsed;

  /// List of actions to be added to the appbar
  final List<AppBarAction> actions;

  /// Title space of the appbar
  final double? titleSpacing;

  final double appBarHeight;

  final double titleHeight;

  final double subtitleHeight;

  final int actionOverflowThreshold;

  final WidgetBuilder? collapsedBuilder;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final resolvedGap = gap ?? 8;
    final resolvedPadding = padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    final maybeTitle = title.isNull
        ? null
        : DefaultTextStyle(
            style: textTheme.titleLarge!,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            child: title!,
          );

    final overflowedActions = actions.skip(actionOverflowThreshold).toList(growable: false);
    final List<Widget> displayedActions = actions
        .where((action) {
          return action.isNotNull || action.child.isNotNull;
        })
        .take(actionOverflowThreshold)
        .map(
          (action) {
            return action.icon.isNull
                ? action.child!
                : IconButton(
                    icon: Icon(action.icon, fill: action.fill ? 1 : 0),
                    tooltip: action.tooltip,
                    onPressed: action.onPressed,
                  );
          },
        )
        .toList();
    final appBarActions = overflowedActions.isEmpty
        ? displayedActions
        : [
            ...displayedActions,
            PopupMenuButton<AppBarAction>(
              tooltip: 'More',
              onSelected: (action) => action.onPressed?.call(),
              itemBuilder: (context) {
                return overflowedActions
                    .map((action) {
                      return PopupMenuItem(
                        value: action,
                        child: ListTile(
                          dense: true,
                          leading: Icon(action.icon),
                          title: Text(action.tooltip),
                        ),
                      );
                    })
                    .toList(growable: false);
              },
            ),
          ];

    final List<PreferredSizeWidget> flexibleChildren;
    if (flexibleSpace.isNull) {
      flexibleChildren = [
        if (flexibleTop.isNotNull) flexibleTop!,
        if (maybeTitle.isNotNull)
          PreferredSize(
            preferredSize: Size.fromHeight(titleHeight),
            child: maybeTitle!,
          ),
        if (flexibleMid.isNotNull) flexibleMid!,
        if (subtitle.isNotNull)
          PreferredSize(
            preferredSize: Size.fromHeight(subtitleHeight),
            child: DefaultTextStyle(
              style: textTheme.bodyMedium!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              child: subtitle!,
            ),
          ),
        if (flexibleBottom.isNotNull) flexibleBottom!,
      ];
    } else {
      flexibleChildren = [flexibleSpace!];
    }

    final gapCount = flexibleChildren.isEmpty ? 0 : flexibleChildren.length - 1;
    final height =
        appBarHeight +
        resolvedPadding.top +
        flexibleChildren.fold(0, (sum, item) => sum + item.preferredSize.height) +
        (gapCount * resolvedGap) +
        resolvedPadding.bottom;

    final appBar = collapsed
        ? null
        : BasicFlexibleSpace(
            maxHeight: height,
            padding: resolvedPadding,
            gap: resolvedGap,
            actionCount: appBarActions.length,
            collapsedBuilder: collapsedBuilder ?? (maybeTitle.isNull ? null : (_) => maybeTitle!),
            appBarHeight: appBarHeight,
            children: flexibleChildren,
          );

    return SliverAppBar(
      expandedHeight: collapsed ? null : height,
      collapsedHeight: appBarHeight,
      title: collapsed
          ? maybeTitle.isNotNull
                ? maybeTitle
                : null
          : null,
      titleSpacing: titleSpacing,
      flexibleSpace: appBar,
      snap: snap,
      floating: true,
      pinned: pinned,
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: appBarActions,
    );
  }
}
