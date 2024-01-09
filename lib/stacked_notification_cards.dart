library stacked_notification_cards;

import 'package:flutter/material.dart';

import 'src/build_stacked_notification.dart';
import 'src/model/notification_card.dart';
import 'src/stacked_cards/expanded_list.dart';

export 'src/model/notification_card.dart';

/// This package will let you
class StackedNotificationCards extends StatelessWidget {
  /// List of [NotificationCard]s to show.
  final List<NotificationCard> notificationCards;

  /// Color of each card.
  final Color cardColor;

  /// Corner radius of [NotificationCard].
  final double cardCornerRadius;

  /// Spacing between [NotificationCard]s  when they are expanded.
  final double cardsSpacing;

  /// Padding around the whole widget.
  final double padding;

  /// Title of all [NotificationCard]s, this will be same when they are in a list.
  final String notificationCardTitle;

  /// [TextStyle] of each [NotificationCard]'s title.
  final TextStyle titleTextStyle;

  /// TextStyle of each [NotificationCard]'s subtitle.
  final TextStyle? subtitleTextStyle;

  /// Shadow behind every [NotificationCard].
  final List<BoxShadow>? boxShadow;

  /// Callback when clearAllStacked or clearAllNotificationsAction button pressed.
  final VoidCallback onTapClearAll;

  /// This widget is show the top-right after headerShowLess. Visible when the
  /// cards are expanded.
  final Widget clearAllNotificationsAction;

  /// When notifications are stacked this widget is shown behind the card.
  /// visible when the card is slide
  final Widget clearAllStacked;

  /// This widget is shown at the top-left of all notifications
  final Widget actionTitle;

  /// This widget is shown at the top-right of all notifications and has on tap clearAll callback.
  final Widget? showLessAction;

  /// This widget is stacked behind each [NotificationCard] visible when [NotificationCard] is slide.
  /// Used to view details notification.
  final Widget cardViewButton;

  /// This widget is stacked behind each [NotificationCard] visible when [NotificationCard] is slide.
  /// Used to clear the notification.
  final Widget cardClearButton;

  /// Callback when tapped on cardViewButton widget after sliding card. This callback
  /// is used to show more details about the notification
  final OnTapSlidButtonCallback onTapViewCallback;

  /// Callback when tapped on cardClearButton widget after sliding card. This callback
  /// is used to clear the card. Also tigger a shirnk animation.
  final OnTapSlidButtonCallback onTapClearCallback;
// Assign a list of random colors to the card

  //Notification counter text
  final String? lastNotificationText;
  //Notification counter visibility
  final bool? notificationCounter;
  //Date text
  final String? dateText;
  //List ramdon colors

  const StackedNotificationCards({
    Key? key,
    required this.notificationCards,
    required this.cardColor,
    required this.notificationCardTitle,
    required this.onTapClearAll,
    required this.clearAllNotificationsAction,
    required this.clearAllStacked,
    required this.cardClearButton,
    required this.cardViewButton,
    required this.onTapClearCallback,
    required this.onTapViewCallback,
    required this.actionTitle,
    this.showLessAction = const SizedBox.shrink(),
    this.lastNotificationText = "more notifications",
    this.notificationCounter = true,
    this.boxShadow,
    this.titleTextStyle = const TextStyle(fontWeight: FontWeight.w500),
    this.subtitleTextStyle,
    this.cardCornerRadius = 8,
    this.cardsSpacing = 10,
    this.padding = 0,
    this.dateText = "Today",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (notificationCards.length > 0) {
      return BuildStackedNotification(
        key: ValueKey(notificationCardTitle),
        notificationCards: notificationCards,
        tileColor: cardColor,
        cornerRadius: cardCornerRadius,
        spacing: cardsSpacing,
        padding: padding,
        notificationCardTitle: notificationCardTitle,
        titleTextStyle: titleTextStyle,
        subtitleTextStyle: subtitleTextStyle,
        boxShadow: boxShadow,
        onTapClearAll: onTapClearAll,
        clearAllNotificationsAction: clearAllNotificationsAction,
        clearAllStacked: clearAllStacked,
        clear: cardClearButton,
        view: cardViewButton,
        onTapViewCallback: onTapViewCallback,
        onTapClearCallback: onTapClearCallback,
        headerTitle: actionTitle,
        showLessAction: showLessAction!,
        dateText: dateText!,
        notificationCounter: notificationCounter!,
        lastNotificationText: lastNotificationText!,
      );
    } else {
      return SizedBox.shrink(
        key: ValueKey('EmptySizedBox'),
      );
    }
  }
}
