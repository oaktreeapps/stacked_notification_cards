import 'package:flutter/material.dart';

import '../../stacked_notification_cards.dart';
import '../notification_tile/notification_tile.dart';

/// This  widget shows when all [NotificationCard]s are stacked
/// and animates (fans out) when tapped on the grouped (stacked) [NotificationCard].
/// Will be replaced by [ExpandedList].
class AnimatedOffsetList extends StatelessWidget {
  final AnimationController controller;
  final Interval interval;
  final List<NotificationCard> notificationCards;
  final double height;
  final double spacing;
  final Color tileColor;
  final double cornerRadius;
  final String notificationCardTitle;
  final TextStyle titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final List<BoxShadow>? boxShadow;
  final double padding;

  final Interval opacityInterval;

  const AnimatedOffsetList({
    Key? key,
    required this.controller,
    required this.interval,
    required this.notificationCards,
    required this.height,
    required this.spacing,
    required this.cornerRadius,
    required this.tileColor,
    required this.notificationCardTitle,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.boxShadow,
    required this.opacityInterval,
    required this.padding,
  }) : super(key: key);

  /// Gives initial value depending on the number of [NotificationCard]s
  double _getInitialValue(int index) {
    final length = notificationCards.length;

    if (index == length - 1) {
      return 0.0;
    } else if (index == length - 2) {
      return spacing / 2;
    } else {
      return spacing;
    }
  }

  /// Gives final offset value. This value will be used
  /// to offset each card when they expanded (while animating)
  /// offset value is zero for the first (top) card.
  double _finalOffsetValue(int index) {
    final length = notificationCards.length;
    final double tileHeight = height + spacing;

    if (index == length - 1) {
      return 0.0;
    } else {
      return ((length - index - 1) * tileHeight);
    }
  }

  /// Gives initial scale value to scale down
  /// first (top) card will not be scaled
  double _initialScaleValue(int index) {
    final length = notificationCards.length;
    if (index == length - 1) {
      return 1.0;
    } else if (index == length - 2) {
      return 0.95;
    } else {
      return 0.9;
    }
  }

  /// Gives initial opacity to all [NotificationCard]s
  /// All cards will be transparent expect first 3 cards, when stacked.
  double _initialOpacityValue(int index) {
    final length = notificationCards.length;
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

  /// Gives Tween animation offset value to offset each card
  /// from initial to final.
  Offset _tileOffset(int index) {
    return Tween(
            begin: Offset(0, _getInitialValue(index)),
            end: Offset(0, _finalOffsetValue(index)))
        .animate(
          CurvedAnimation(parent: controller, curve: interval),
        )
        .value;
  }

  /// Gives Tween animation scale value to scale each card
  /// from initial to final.
  double _tileScale(int index) {
    return Tween(begin: _initialScaleValue(index), end: 1.0)
        .animate(
          CurvedAnimation(parent: controller, curve: interval),
        )
        .value;
  }

  /// Gives Tween animation opacity value to make transparent
  /// each card from initial to final.
  double _tileOpacity(int index) {
    return Tween(begin: _initialOpacityValue(index), end: 1.0)
        .animate(
          CurvedAnimation(parent: controller, curve: opacityInterval),
        )
        .value;
  }

  /// This required to replace the last card from this list
  /// with the [LastNotificationCard]. There wise there will be two
  /// cards shown at the top.
  bool _lastCardVisibility(int index) {
    final length = notificationCards.length;
    if (index == length - 1 && controller.value <= 0.4) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: notificationCards.length > 1 && controller.value <= 0.8,
      child: Stack(
        key: ValueKey('AnimatedOffsetList'),
        children: [
          ...notificationCards.map(
            (notification) {
              final index = notificationCards.indexOf(notification);
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
                        cardTitle: notificationCardTitle,
                        date: notification.date,
                        title: notification.title,
                        subtitle: notification.subtitle,
                        height: height,
                        color: tileColor,
                        cornerRadius: cornerRadius,
                        titleTextStyle: titleTextStyle,
                        subtitleTextStyle: subtitleTextStyle,
                        boxShadow: boxShadow,
                        padding: EdgeInsets.symmetric(
                          horizontal: padding,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
