library stacked_notification_cards;

import 'package:flutter/material.dart';

import 'src/build_stacked_notification.dart';
import 'src/model/notification_card.dart';
import 'src/stacked_cards/expanded_list.dart';

export 'src/model/notification_card.dart';

/// This package will let you
class StackedNotificationCards extends StatelessWidget {
  /// List of notifications to show.
  final List<NotificationCard> notifications;

  /// Color of each tile.
  final Color cardColor;

  /// Corner radius of tiles.
  final double cornerRadius;

  /// Spacing between tiles when they are expanded.
  final double cardsSpacing;

  /// Padding around the whole widget.
  final double padding;

  /// Type of the each grouped cards.
  final String type;

  /// TextStyle of each notification card title.
  final TextStyle titleTextStyle;

  /// TextStyle of each notification card subtitle.
  final TextStyle? subtitleTextStyle;

  /// Shadow behind every single card.
  final List<BoxShadow>? shadow;

  /// Callback when clear all button pressed.
  final VoidCallback onTapClearAll;

  /// This widget is show the top-right after headerShowLess. Visible when the
  /// cards are expanded.
  final Widget headerClearAllButton;

  /// When notifications are stacked this widget is shown behind the card.
  /// visible when the card is slide
  final Widget clearAllStacked;

  /// This widget is shown at the top-left of all notifications
  final Widget headerTitle;

  /// This widget is shown at the top-right of all notifications and has onTapClearAll callback.
  final Widget headerShowLess;

  /// View widget when card is slide
  final Widget view;

  /// Clear widget when card is slide
  final Widget clear;

  /// Callback when tapped on view widget after sliding card.
  final OnTapSlidButtonCallback onTapViewCallback;

  /// Callback when tapped on clear widget after sliding card.
  final OnTapSlidButtonCallback onTapClearCallback;

  const StackedNotificationCards({
    Key? key,
    required this.notifications,
    required this.cardColor,
    required this.type,
    required this.onTapClearAll,
    required this.headerClearAllButton,
    required this.clearAllStacked,
    required this.clear,
    required this.view,
    required this.onTapClearCallback,
    required this.onTapViewCallback,
    required this.headerTitle,
    required this.headerShowLess,
    this.shadow,
    this.titleTextStyle = const TextStyle(fontWeight: FontWeight.w500),
    this.subtitleTextStyle,
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
        type: type,
        titleTextStyle: titleTextStyle,
        subtitleTextStyle: subtitleTextStyle,
        shadow: shadow,
        onTapClearAll: onTapClearAll,
        headerClearAllButton: headerClearAllButton,
        clearAllStacked: clearAllStacked,
        clear: clear,
        view: view,
        onTapViewCallback: onTapViewCallback,
        onTapClearCallback: onTapClearCallback,
        headerTitle: headerTitle,
        headerShowLess: headerShowLess,
      );
    } else {
      return SizedBox.shrink(
        key: ValueKey('EmptySizedBox'),
      );
    }
  }
}
