import 'package:flutter/material.dart';
import '../model/notification_card.dart';

class OffsetSpacer extends StatelessWidget {
  final AnimationController controller;
  final List<NotificationCard> notifications;
  final double height;
  final double spacing;
  final double padding;
  final initialHeight;
  const OffsetSpacer({
    Key? key,
    required this.controller,
    required this.notifications,
    required this.height,
    required this.spacing,
    required this.initialHeight,
    required this.padding,
  }) : super(key: key);

  double _getInitialHeight() {
    final length = notifications.length;
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
        key: ValueKey('SpacerSizedBox'),
        height: Tween<double>(
          begin: _getInitialHeight(),
          end: notifications.length * (height + spacing),
        )
            .animate(
              CurvedAnimation(
                parent: controller,
                curve: Interval(0.4, 0.8),
              ),
            )
            .value,
        // color: Colors.amberAccent.withOpacity(0.2),
      ),
    );
  }
}
