library stacked_notification_cards;

import 'package:flutter/material.dart';
import 'src/build_stacked_notification.dart';
import 'src/model/notification_card.dart';
export 'src/model/notification_card.dart';

/// This package will let you
class StackedNotificationCards extends StatelessWidget {
  /// List of notifications
  final List<NotificationCard> notifications;

  /// Color of each tiles
  final Color cardColor;

  /// Corner radius of tiles
  final double cornerRadius;

  /// Spacing between tiles when they are expanded
  final double cardsSpacing;

  /// Padding around the whole widget
  final double padding;

  const StackedNotificationCards({
    Key? key,
    required this.notifications,
    required this.cardColor,
    this.cornerRadius = 8,
    this.cardsSpacing = 10,
    this.padding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (notifications.length > 0) {
      return BuildStackedNotification(
        key: ValueKey('BuildStackedNotification'),
        notifications: notifications,
        tileColor: cardColor,
        cornerRadius: cornerRadius,
        spacing: cardsSpacing,
        padding: padding,
      );
    } else {
      return SizedBox.shrink(
        key: ValueKey('EmptySizedBox'),
      );
    }
  }
}
