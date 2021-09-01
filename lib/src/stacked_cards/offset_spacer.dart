import 'package:flutter/material.dart';

/// This widget is stacked behind [AnimatedOffsetList],
/// and provides the height when cards are fans out, otherwise they
/// would overlap on the following widget.
/// It pushes any following widget down in the list.
/// It animates it's height when the [AnimatedOffsetList] animates.
/// Will disappear when Expanded List will be shown.
class OffsetSpacer extends StatelessWidget {
  final AnimationController controller;
  final int notificationCount;
  final double height;
  final double spacing;
  final double padding;
  const OffsetSpacer({
    Key? key,
    required this.controller,
    required this.notificationCount,
    required this.height,
    required this.spacing,
    required this.padding,
  }) : super(key: key);

  /// This method provides initial height depending on
  /// number of notifications.
  double _getInitialHeight() {
    final length = notificationCount;
    if (length == 1) {
      return padding;
    } else if (length == 2) {
      return height + spacing / 2 + padding;
    } else {
      return height + spacing + padding;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: controller.value <= 0.8,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: padding),
        key: ValueKey('SpacerSizedBox'),
        height: Tween<double>(
          begin: _getInitialHeight(),
          end: notificationCount * (height + spacing),
        )
            .animate(
              CurvedAnimation(
                parent: controller,
                curve: Interval(0.4, 0.8),
              ),
            )
            .value,
      ),
    );
  }
}
