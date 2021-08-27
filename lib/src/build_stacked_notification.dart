import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'collapsed_cards/collapsed_cards.dart';
import 'expanded_list/expanded_list.dart';
import 'header/header.dart';
import 'model/notification_card.dart';
import 'notification_tile/notification_tile.dart';
import 'notification_tile/slid_button.dart';

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
  final Widget clearAll;
  final Widget view;
  final Widget clear;
  final OnTapSlidButtonCallback onTapViewCallback;
  final OnTapSlidButtonCallback onTapClearCallback;
  final Widget headerTitle;
  final Widget headerShowLess;
  // final Widget headerClearAll;

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
    required this.clearAll,
    required this.clear,
    required this.view,
    required this.onTapClearCallback,
    required this.onTapViewCallback,
    required this.headerTitle,
    // required this.headerClearAll,
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
    final clearAll = widget.clearAll;

    final view = widget.view;
    final clear = widget.clear;
    final onTapViewCallback = widget.onTapViewCallback;
    final onTapClearCallback = widget.onTapClearCallback;
    final headerTitle = widget.headerTitle;
    final headerShowLess = widget.headerShowLess;
    // final headerClearAll = widget.headerClearAll;

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
            title: headerTitle,
            showLess: headerShowLess,
            onTapShowLess: () {
              setState(() {
                _isExpanded = false;
              });
              _animationController.reverse();
            },
          ),
          Visibility(
            visible: notifications.length == 1,
            child: Slidable(
              actionPane: SlidableBehindActionPane(),
              secondaryActions: [
                SlidButton(
                  padding: EdgeInsets.fromLTRB(0, 0, padding, 0),
                  color: tileColor,
                  shadow: shadow,
                  height: _containerHeight,
                  child: view,
                  onTapButton: () {
                    onTapViewCallback(0);
                  },
                  leftCornerRadius: cornerRadius,
                  rightCornerRadius: cornerRadius,
                ),
                SlidButton(
                  padding: EdgeInsets.fromLTRB(0, 0, padding, 0),
                  color: tileColor,
                  shadow: shadow,
                  height: _containerHeight,
                  child: clear,
                  onTapButton: () {
                    onTapClearCallback(0);
                  },
                  rightCornerRadius: cornerRadius,
                  leftCornerRadius: cornerRadius,
                ),
              ],
              child: NotificationTile(
                key: ValueKey('NotificationTile'),
                heading: type,
                dateTime: notifications.first.dateTime,
                title: notifications.first.title,
                subtitle: notifications.first.subtitle,
                height: _containerHeight,
                color: tileColor,
                cornerRadius: cornerRadius,
                padding: EdgeInsets.symmetric(horizontal: padding),
                titleTextStyle: titleStyle,
                subtitleTextStyle: subtitleStyle,
                shadow: shadow,
              ),
            ),
          ),
          Visibility(
            visible: notifications.length > 1,
            child: CollapsedCards(
              onTapClearCallback: onTapClearCallback,
              onTapViewCallback: onTapViewCallback,
              clear: clear,
              view: view,
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
              clearAll: clearAll,
              onTapShowMore: () async {
                await _animationController.forward();
                setState(() {
                  _isExpanded = true;
                });
              },
            ),
          ),
          ExpandedList(
            type: type,
            controller: _animationController,
            containerHeight: _containerHeight,
            spacing: spacing,
            initialSpacing: 2 * spacing,
            notifications: notifications,
            tileColor: tileColor,
            cornerRadius: cornerRadius,
            tilePadding: padding,
            titleTextStyle: titleStyle,
            subtitleTextStyle: subtitleStyle,
            shadow: shadow,
            clear: clear,
            view: view,
            onTapViewCallback: onTapViewCallback,
            onTapClearCallback: onTapClearCallback,
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
