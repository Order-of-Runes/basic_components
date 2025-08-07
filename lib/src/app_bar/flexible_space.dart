import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

const double _topExtent = 8;

class BasicFlexibleSpace extends StatelessWidget {
  const BasicFlexibleSpace({
    super.key,
    required this.appBarHeight,
    required this.maxHeight,
    required this.children,
    this.padding = EdgeInsets.zero,
    this.gap = 0,
    this.actionCount = 0,
    this.collapsedBuilder,
  });

  final List<PreferredSizeWidget> children;

  final double appBarHeight;
  final double maxHeight;
  final double gap;
  final int actionCount;

  final EdgeInsets padding;

  /// Should return widget that is to be displayed when app is collapsed
  final WidgetBuilder? collapsedBuilder;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 100);
    return LayoutBuilder(
      builder: (context, constraint) {
        final t = ((constraint.maxHeight - appBarHeight) / (maxHeight - appBarHeight)).clamp(
          0.0,
          1.0,
        );

        double topSpace = appBarHeight + padding.top;

        final widgets = children.indexed
            .map((records) {
              final (index, item) = records;

              if (index > 0) {
                topSpace += children[index - 1].preferredSize.height + gap;
              }

              return AnimatedPositioned(
                left: padding.left,
                right: padding.right,
                top: (topSpace * t).clamp(_topExtent, topSpace),
                duration: duration,
                child: AnimatedOpacity(duration: duration, opacity: t == 1 ? t : (t * (t - 0.7)).clamp(0, 1), child: item),
              );
            })
            .toList(growable: false);

        return Stack(
          children: [
            if (collapsedBuilder.isNotNull)
              AnimatedPositioned(
                duration: duration,
                left: 0,
                top: appBarHeight * t,
                child: AnimatedOpacity(
                  duration: duration,
                  opacity: (1 - (t * 3)).clamp(0, 1),
                  child: SizedBox(
                    height: appBarHeight,
                    width: constraint.maxWidth - (48 * actionCount) - (actionCount == 0 ? 0 : 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 72),
                        child: collapsedBuilder!(context),
                      ),
                    ),
                  ),
                ),
              ),
            ...widgets,
          ],
        );
      },
    );
  }
}
