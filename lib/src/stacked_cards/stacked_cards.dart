import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'animated_offset_list.dart';

import 'offset_spacer.dart';
import 'last_notification_card.dart';
import '../model/notification_card.dart';
import '../notification_tile/slid_button.dart';
import 'expanded_list.dart';

/// Second widget in the column this widget is responsible
/// for stacking cards as well showing fan animation,
/// also shows the list of cards when expanded.
class StackedCards extends StatelessWidget {
  final AnimationController controller;
  final List<NotificationCard> notifications;
  final double containerHeight;
  final double spacing;
  final double maxSpacing;
  final Color containerColor;
  final double cornerRadius;
  final double padding;
  final String type;
  final TextStyle titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final List<BoxShadow>? shadow;
  final VoidCallback onTapClearAll;
  final Widget view;
  final Widget clear;
  final OnTapSlidButtonCallback onTapViewCallback;
  final OnTapSlidButtonCallback onTapClearCallback;
  final Widget clearAllStacked;

  StackedCards({
    Key? key,
    required this.controller,
    required this.notifications,
    required this.containerHeight,
    required this.spacing,
    required this.maxSpacing,
    required this.containerColor,
    required this.cornerRadius,
    required this.padding,
    required this.type,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.shadow,
    required this.onTapClearAll,
    required this.clear,
    required this.view,
    required this.onTapClearCallback,
    required this.onTapViewCallback,
    required this.clearAllStacked,
  }) : super(key: key);

  /// This method gives the bottom padding that is used
  /// for 'Clear All' bottom when stacked cards are slide

  double _getSlidButtonPadding() {
    final length = notifications.length;
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
    /// this notification will be shown in LastNotificationCard
    final lastNotification = notifications.last;

    /// wrapped in Slidable, this will help to slide when cards are stacked (groupped).
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
          SlidButton(
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
            shadow: shadow,
            onTapButton: (context) async {
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
            notificationCount: notifications.length,
            padding: padding,
          ),
          AnimatedOffsetList(
            type: type,
            padding: padding,
            controller: controller,
            interval: Interval(0.4, 0.8),
            notifications: notifications,
            height: containerHeight,
            spacing: maxSpacing,
            cornerRadius: cornerRadius,
            tileColor: containerColor,
            titleTextStyle: titleTextStyle,
            subtitleTextStyle: subtitleTextStyle,
            shadow: shadow,
            opacityInterval: Interval(0.4, 0.6),
          ),
          LastNotificationCard(
            type: type,
            controller: controller,
            notification: lastNotification,
            totalCount: notifications.length,
            height: containerHeight,
            color: containerColor,
            cornerRadius: cornerRadius,
            titleTextStyle: titleTextStyle,
            subtitleTextStyle: subtitleTextStyle,
            shadow: shadow,
            padding: padding,
          ),
          ExpandedList(
            type: type,
            controller: controller,
            containerHeight: containerHeight,
            spacing: spacing,
            initialSpacing: 2 * spacing,
            notifications: notifications,
            tileColor: containerColor,
            cornerRadius: cornerRadius,
            tilePadding: padding,
            titleTextStyle: titleTextStyle,
            subtitleTextStyle: subtitleTextStyle,
            shadow: shadow,
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
