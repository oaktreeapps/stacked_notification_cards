import 'package:flutter/material.dart';

import '../model/notification_card.dart';
import '../notification_tile/notification_tile.dart';

class ExpandedList extends StatelessWidget {
  final List<NotificationCard> notifications;
  final AnimationController controller;
  final double initialSpacing;
  final double spacing;
  final double tilePadding;

  final double containerHeight;
  final Color tileColor;
  final double cornerRadius;
  const ExpandedList({
    Key? key,
    required this.notifications,
    required this.controller,
    required this.containerHeight,
    required this.initialSpacing,
    required this.spacing,
    required this.cornerRadius,
    required this.tileColor,
    required this.tilePadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double topTilePadding =
        Tween<double>(begin: initialSpacing, end: spacing)
            .animate(
              CurvedAnimation(
                parent: controller,
                curve: Interval(0.8, 1.0),
              ),
            )
            .value;

    final updatedNotifications = List.of(notifications);
    updatedNotifications.removeAt(0);
    return Stack(
      children: [
        Visibility(
          visible: controller.value <= 0.8,
          child: SizedBox(
            key: ValueKey('SpacerSizedBox'),
            height: Tween<double>(
              begin: 0.0,
              end: updatedNotifications.length *
                  (containerHeight + initialSpacing),
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
        ),
        Visibility(
          visible: controller.value >= 0.8,
          child: Column(
            key: ValueKey('FinalColumn'),
            children: [
              ...updatedNotifications.map(
                (notification) => NotificationTile(
                  heading: 'Message',
                  dateTime: notification.dateTime,
                  title: notification.title,
                  subtitle: notification.subtitle,
                  spacing: spacing,
                  height: containerHeight,
                  color: tileColor,
                  cornerRadius: cornerRadius,
                  padding: EdgeInsets.fromLTRB(
                    tilePadding,
                    topTilePadding,
                    tilePadding,
                    0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
