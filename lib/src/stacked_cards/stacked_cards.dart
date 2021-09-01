import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/notification_card.dart';
import '../notification_tile/slide_button.dart';
import 'animated_offset_list.dart';
import 'expanded_list.dart';
import 'last_notification_card.dart';
import 'offset_spacer.dart';

/// Shows stack of cards
///
/// This widget is responsible for showing the stack of cards along with the fan animation on expansion. Also handles [OnTapSlidButtonCallback].
class StackedCards extends StatelessWidget {
  final AnimationController controller;
  final List<NotificationCard> notificationCards;
  final double containerHeight;
  final double spacing;
  final double maxSpacing;
  final Color containerColor;
  final double cornerRadius;
  final double padding;
  final String notificationCardTitle;
  final TextStyle titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final List<BoxShadow>? boxShadow;
  final VoidCallback onTapClearAll;
  final Widget view;
  final Widget clear;
  final OnTapSlidButtonCallback onTapViewCallback;
  final OnTapSlidButtonCallback onTapClearCallback;
  final Widget clearAllStacked;

  StackedCards({
    Key? key,
    required this.controller,
    required this.notificationCards,
    required this.containerHeight,
    required this.spacing,
    required this.maxSpacing,
    required this.containerColor,
    required this.cornerRadius,
    required this.padding,
    required this.notificationCardTitle,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.boxShadow,
    required this.onTapClearAll,
    required this.clear,
    required this.view,
    required this.onTapClearCallback,
    required this.onTapViewCallback,
    required this.clearAllStacked,
  }) : super(key: key);

  /// This method gives the bottom padding that is used
  /// for 'Clear All' bottom when stacked cards are slid over
  double _getSlidButtonPadding() {
    final length = notificationCards.length;
    if (length == 1) {
      return padding;
    } else if (length == 2) {
      return spacing + padding;
    } else {
      return (2 * spacing) + padding;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// this notification will be shown in [LastNotificationCard]
    final lastNotification = notificationCards.last;

    /// Wrapped in [Slidable], this will help to slide when cards are stacked.
    return Slidable(
      key: ValueKey('0'),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        openThreshold: 0.25,
        closeThreshold: 0.5,
        motion: BehindMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => onTapClearAll,
        ),
        children: [
          SlideButton(
            padding: EdgeInsets.fromLTRB(
              0,
              0,
              padding,
              _getSlidButtonPadding(),
            ),
            color: containerColor,
            height: containerHeight,
            leftCornerRadius: cornerRadius,
            rightCornerRadius: cornerRadius,
            boxShadow: boxShadow,
            onTap: (context) async {
              onTapClearAll();
            },
            child: clearAllStacked,
          )
        ],
      ),
      child: Stack(
        children: [
          OffsetSpacer(
            height: containerHeight,
            controller: controller,
            spacing: 2 * spacing,
            notificationCount: notificationCards.length,
            padding: padding,
          ),
          AnimatedOffsetList(
            notificationCardTitle: notificationCardTitle,
            padding: padding,
            controller: controller,
            interval: Interval(0.4, 0.8),
            notificationCards: notificationCards,
            height: containerHeight,
            spacing: maxSpacing,
            cornerRadius: cornerRadius,
            tileColor: containerColor,
            titleTextStyle: titleTextStyle,
            subtitleTextStyle: subtitleTextStyle,
            boxShadow: boxShadow,
            opacityInterval: Interval(0.4, 0.6),
          ),
          LastNotificationCard(
            notificationCardTitle: notificationCardTitle,
            controller: controller,
            notification: lastNotification,
            totalCount: notificationCards.length,
            height: containerHeight,
            color: containerColor,
            cornerRadius: cornerRadius,
            titleTextStyle: titleTextStyle,
            subtitleTextStyle: subtitleTextStyle,
            boxShadow: boxShadow,
            padding: padding,
          ),
          ExpandedList(
            notificationCardTitle: notificationCardTitle,
            controller: controller,
            containerHeight: containerHeight,
            spacing: spacing,
            initialSpacing: 2 * spacing,
            notificationCards: notificationCards,
            tileColor: containerColor,
            cornerRadius: cornerRadius,
            tilePadding: padding,
            titleTextStyle: titleTextStyle,
            subtitleTextStyle: subtitleTextStyle,
            boxShadow: boxShadow,
            clear: clear,
            view: view,
            endPadding: padding,
            onTapViewCallback: onTapViewCallback,
            onTapClearCallback: onTapClearCallback,
          ),
        ],
      ),
    );
  }
}
