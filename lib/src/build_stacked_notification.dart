import 'package:flutter/material.dart';
import 'collapsed_cards/collapsed_cards.dart';
import 'expanded_list/expanded_list.dart';
import 'header/header.dart';
import 'model/notification_card.dart';
import 'notification_tile/notification_tile.dart';

class BuildStackedNotification extends StatefulWidget {
  final List<NotificationCard> notifications;
  final Color tileColor;
  final double cornerRadius;
  final double spacing;
  final double padding;

  BuildStackedNotification({
    Key? key,
    required this.notifications,
    required this.tileColor,
    required this.cornerRadius,
    required this.spacing,
    required this.padding,
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
    notifications.sort((a, b) => a.dateTime.compareTo(b.dateTime));

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
            onTapShowLess: () {
              setState(() {
                _isExpanded = false;
              });
              _animationController.reverse();
            },
          ),
          Visibility(
            visible: notifications.length == 1,
            child: NotificationTile(
              key: ValueKey('NotificationTile'),
              heading: 'Message',
              dateTime: notifications.first.dateTime,
              title: notifications.first.title,
              subtitle: notifications.first.subtitle,
              height: _containerHeight,
              color: tileColor,
              cornerRadius: cornerRadius,
              padding: EdgeInsets.symmetric(horizontal: padding),
            ),
          ),
          Visibility(
            visible: notifications.length > 1,
            child: CollapsedCards(
              key: ValueKey('CollapsedCards'),
              controller: _animationController,
              notifications: notifications,
              containerHeight: _containerHeight,
              spacing: spacing,
              maxSpacing: 2 * spacing,
              isExpaned: _isExpanded,
              containerColor: tileColor,
              cornerRadius: cornerRadius,
              padding: padding,
              onTapShowMore: () async {
                await _animationController.forward();
                setState(() {
                  _isExpanded = true;
                });
              },
            ),
          ),
          ExpandedList(
            controller: _animationController,
            containerHeight: _containerHeight,
            spacing: spacing,
            initialSpacing: 2 * spacing,
            notifications: notifications,
            tileColor: tileColor,
            cornerRadius: cornerRadius,
            tilePadding: padding,
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
