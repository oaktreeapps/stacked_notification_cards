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
  final String type;
  final TextStyle titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final List<BoxShadow>? shadow;

  final Interval opacityInterval;

  const AnimatedOffsetList({
    Key? key,
    required this.controller,
    required this.interval,
    required this.notifications,
    required this.height,
    required this.spacing,
    required this.cornerRadius,
    required this.tileColor,
    required this.type,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.shadow,

    required this.opacityInterval,
  }) : super(key: key);

  double _getInitialValue(int index) {
    final length = notifications.length;

    if (index == length - 1) {
      return 0.0;
    } else if (index == length - 2) {
      return spacing / 2;
    } else {
      return spacing;
    }
  }

  double _finalOffsetValue(int index) {
    final length = notifications.length;
    final double tileHeight = height + spacing;

    if (index == length - 1) {
      return 0.0;
    } else {
      return ((length - index - 1) * tileHeight);
    }
  }

  double _initialScaleValue(int index) {
    final length = notifications.length;
    if (index == length - 1) {
      return 1.0;
    } else if (index == length - 2) {
      return 0.95;
    } else {
      return 0.9;
    }
  }

  double _initialOpacityValue(int index) {
    final length = notifications.length;
    if (index == length - 1) {
      return 1.0;
    } else if (index == length - 2) {
      return 1.0;
    } else if (index == length - 3) {
      return 1.0;
    } else {
      return 0.0;
    }
  }

  Offset _tileOffset(int index) {
    return Tween(
            begin: Offset(0, _getInitialValue(index)),
            end: Offset(0, _finalOffsetValue(index)))
        .animate(
          CurvedAnimation(parent: controller, curve: interval),
        )
        .value;
  }

  double _tileScale(int index) {
    return Tween(begin: _initialScaleValue(index), end: 1.0)
        .animate(
          CurvedAnimation(parent: controller, curve: interval),
        )
        .value;
  }

  double _tileOpacity(int index) {
    return Tween(begin: _initialOpacityValue(index), end: 1.0)
        .animate(
          CurvedAnimation(parent: controller, curve: opacityInterval),
        )
        .value;
  }

// This required to replace the last card from this list
//with the LastNotificationCard
  bool _lastCardVisibility(int index) {
    final length = notifications.length;
    if (index == length - 1 && controller.value <= 0.4) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final updatedNotifications = List.of(notifications);
    // updatedNotifications.removeAt(0);

    return Stack(
      children: [
        ...notifications.map(
          (notification) {
            final index = notifications.indexOf(notification);
            return Transform.translate(
              offset: _tileOffset(index),
              child: Transform.scale(
                alignment: Alignment.bottomCenter,
                scale: _tileScale(index),
                child: Opacity(
                  opacity: _tileOpacity(index),
                  child: Visibility(
                    visible: _lastCardVisibility(index),
                    child: NotificationTile(
                      heading: type,
                      dateTime: notification.dateTime,
                      title: notification.title,
                      subtitle: notification.subtitle,
                      height: height,
                      color: tileColor,
                      cornerRadius: cornerRadius,
                      titleTextStyle: titleTextStyle,
                      subtitleTextStyle: subtitleTextStyle,
                      shadow: shadow,
                    ),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
