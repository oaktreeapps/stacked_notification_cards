import 'package:flutter/material.dart';

import '../../stacked_notification_cards.dart';
import '../notification_tile/notification_tile.dart';

class AnimatedOffsetList extends StatelessWidget {
  final AnimationController controller;
  final Interval interval;
  final List<NotificationCard> notifications;
  final double height;
  final double spacing;
  final Color tileColor;
  final double cornerRadius;

  const AnimatedOffsetList({
    Key? key,
    required this.controller,
    required this.interval,
    required this.notifications,
    required this.height,
    required this.spacing,
    required this.cornerRadius,
    required this.tileColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double tileHeight = height + spacing;
    final updatedNotifications = List.of(notifications);
    updatedNotifications.removeAt(0);
    return Stack(
      children: [
        ...updatedNotifications.map(
          (notification) {
            final index = updatedNotifications.indexOf(notification);
            return Transform.translate(
              offset: Tween(
                      end: Offset(0, tileHeight + (index * tileHeight)),
                      begin: Offset.zero)
                  .animate(
                    CurvedAnimation(parent: controller, curve: interval),
                  )
                  .value,
              child: NotificationTile(
                heading: 'Message',
                dateTime: notification.dateTime,
                title: notification.title,
                subtitle: notification.subtitle,
                height: height,
                color: tileColor,
                cornerRadius: cornerRadius,
              ),
            );
          },
        )
      ],
    );
  }
}
