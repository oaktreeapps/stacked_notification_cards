import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'stacked_cards/stacked_cards.dart';
import 'stacked_cards/expanded_list.dart';

import 'header/header.dart';
import 'model/notification_card.dart';

class BuildStackedNotification extends StatefulWidget {
  final List<NotificationCard> notifications;
  final Color tileColor;
  final double cornerRadius;
  final double spacing;
  final double padding;
  final String type;
  final TextStyle titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final List<BoxShadow>? shadow;
  final VoidCallback onTapClearAll;
  // final Widget clearAll;
  final Widget view;
  final Widget clear;
  final OnTapSlidButtonCallback onTapViewCallback;
  final OnTapSlidButtonCallback onTapClearCallback;
  final Widget headerTitle;
  final Widget headerShowLess;
  final Widget headerClearAllButton;
  final Widget clearAllStacked;

  BuildStackedNotification({
    Key? key,
    required this.notifications,
    required this.tileColor,
    required this.cornerRadius,
    required this.spacing,
    required this.padding,
    required this.type,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.shadow,
    required this.onTapClearAll,
    // required this.clearAll,
    required this.clear,
    required this.view,
    required this.onTapClearCallback,
    required this.onTapViewCallback,
    required this.headerTitle,
    required this.headerClearAllButton,
    required this.clearAllStacked,
    required this.headerShowLess,
  }) : super(key: key);

  @override
  _BuildStackedNotificationState createState() =>
      _BuildStackedNotificationState();
}

class _BuildStackedNotificationState extends State<BuildStackedNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final double _containerHeight = 140;
  bool _isExpanded = false;

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
    final notifications = widget.notifications;
    final spacing = widget.spacing;
    final tileColor = widget.tileColor;
    final cornerRadius = widget.cornerRadius;
    final padding = widget.padding;
    final type = widget.type;
    final titleStyle = widget.titleTextStyle;
    final subtitleStyle = widget.subtitleTextStyle;
    final shadow = widget.shadow;
    final onTapClearAll = widget.onTapClearAll;
    // final clearAll = widget.clearAll;

    final view = widget.view;
    final clear = widget.clear;
    final onTapViewCallback = widget.onTapViewCallback;
    final onTapClearCallback = widget.onTapClearCallback;
    final headerTitle = widget.headerTitle;
    final headerShowLess = widget.headerShowLess;
    final headerClearAll = widget.headerClearAllButton;
    final clearAllStacked = widget.clearAllStacked;

    notifications.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    // notifications.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) => Column(
        key: ValueKey('NotificationList'),
        children: [
          Header(
            key: ValueKey('Header'),
            controller: _animationController,
            spacing: spacing,
            padding: padding,
            title: headerTitle,
            showLess: headerShowLess,
            notificationCount: notifications.length,
            clearAll: headerClearAll,
            onTapClearAll: onTapClearAll,
            onTapShowLess: () {
              setState(() {
                _isExpanded = false;
              });
              _animationController.reverse();
            },
          ),
          StackedCards(
            onTapClearCallback: onTapClearCallback,
            onTapViewCallback: onTapViewCallback,
            clear: clear,
            view: view,
            clearAllStacked: clearAllStacked,
            key: ValueKey('CollapsedCards'),
            type: type,
            controller: _animationController,
            notifications: notifications,
            containerHeight: _containerHeight,
            spacing: spacing,
            maxSpacing: 2 * spacing,
            isExpaned: _isExpanded,
            containerColor: tileColor,
            cornerRadius: cornerRadius,
            padding: padding,
            titleTextStyle: titleStyle,
            subtitleTextStyle: subtitleStyle,
            shadow: shadow,
            onTapClearAll: onTapClearAll,
            // clearAll: clearAll,
            onTapShowMore: () async {
              await _animationController.forward();
              setState(() {
                _isExpanded = true;
              });
            },
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
