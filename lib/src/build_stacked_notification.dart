import 'package:flutter/material.dart';
import 'stacked_cards/stacked_cards.dart';
import 'stacked_cards/expanded_list.dart';

import 'stacked_notification_actions/stacked_notification_actions.dart';
import 'model/notification_card.dart';

class BuildStackedNotification extends StatefulWidget {
  final List<NotificationCard> notificationCards;
  final Color tileColor;
  final double cornerRadius;
  final double spacing;
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
  final Widget headerTitle;
  final Widget showLessAction;
  final Widget clearAllNotificationsAction;
  final Widget clearAllStacked;

  BuildStackedNotification({
    Key? key,
    required this.notificationCards,
    required this.tileColor,
    required this.cornerRadius,
    required this.spacing,
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
    required this.headerTitle,
    required this.clearAllNotificationsAction,
    required this.clearAllStacked,
    required this.showLessAction,
  }) : super(key: key);

  @override
  _BuildStackedNotificationState createState() =>
      _BuildStackedNotificationState();
}

class _BuildStackedNotificationState extends State<BuildStackedNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final double _containerHeight = 140;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notificationCards = widget.notificationCards;
    final spacing = widget.spacing;
    final tileColor = widget.tileColor;
    final cornerRadius = widget.cornerRadius;
    final padding = widget.padding;
    final notificationCardTitle = widget.notificationCardTitle;
    final titleStyle = widget.titleTextStyle;
    final subtitleStyle = widget.subtitleTextStyle;
    final boxShadow = widget.boxShadow;
    final onTapClearAll = widget.onTapClearAll;
    final view = widget.view;
    final clear = widget.clear;
    final onTapViewCallback = widget.onTapViewCallback;
    final onTapClearCallback = widget.onTapClearCallback;
    final headerTitle = widget.headerTitle;
    final showLessAction = widget.showLessAction;
    final clearAllNotificationsAction = widget.clearAllNotificationsAction;
    final clearAllStacked = widget.clearAllStacked;

    /// needs to sort to show the list in ascending date order
    notificationCards.sort((a, b) => a.date.compareTo(b.date));

    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) => Column(
        key: ValueKey('NotificationList'),
        children: [
          StackedNotificationActions(
            key: ValueKey('Header'),
            controller: _animationController,
            spacing: spacing,
            padding: padding,
            title: headerTitle,
            showLessAction: showLessAction,
            notificationCount: notificationCards.length,
            clearAllNotificationsAction: clearAllNotificationsAction,
            clearAll: onTapClearAll,
          ),
          StackedCards(
            onTapClearCallback: onTapClearCallback,
            onTapViewCallback: onTapViewCallback,
            clear: clear,
            view: view,
            clearAllStacked: clearAllStacked,
            key: ValueKey('CollapsedCards'),
            notificationCardTitle: notificationCardTitle,
            controller: _animationController,
            notificationCards: notificationCards,
            containerHeight: _containerHeight,
            spacing: spacing,
            maxSpacing: 2 * spacing,
            containerColor: tileColor,
            cornerRadius: cornerRadius,
            padding: padding,
            titleTextStyle: titleStyle,
            subtitleTextStyle: subtitleStyle,
            boxShadow: boxShadow,
            onTapClearAll: onTapClearAll,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
