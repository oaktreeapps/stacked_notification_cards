import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/notification_card.dart';
import '../notification_tile/notification_tile.dart';
import '../notification_tile/slid_button.dart';

typedef void OnTapSlidButtonCallback(int index);

class ExpandedList extends StatelessWidget {
  final List<NotificationCard> notifications;
  final AnimationController controller;
  final double initialSpacing;
  final double spacing;
  final double tilePadding;
  final double endPadding;
  final double containerHeight;
  final Color tileColor;
  final double cornerRadius;
  final String type;
  final TextStyle titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final List<BoxShadow>? shadow;
  final Widget view;
  final Widget clear;
  final OnTapSlidButtonCallback onTapViewCallback;
  final OnTapSlidButtonCallback onTapClearCallback;

  const ExpandedList({
    Key? key,
    required this.notifications,
    required this.controller,
    required this.containerHeight,
    required this.initialSpacing,
    required this.spacing,
    required this.cornerRadius,
    required this.tileColor,
    required this.tilePadding,
    required this.type,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.shadow,
    required this.clear,
    required this.view,
    required this.onTapClearCallback,
    required this.onTapViewCallback,
    required this.endPadding,
  }) : super(key: key);

  double _getSpacing(int index, double topSpace) {
    if (index == 0) {
      return 0;
    } else {
      return topSpace;
    }
  }

  double _topPadding(int index) {
    return Tween<double>(
            begin: _getSpacing(index, initialSpacing),
            end: _getSpacing(index, spacing))
        .animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.8, 1.0),
          ),
        )
        .value;
  }

  double _getEndPadding(int index) {
    if (index == notifications.length - 1) {
      return endPadding;
    } else {
      return 0;
    }
  }




  bool _getListVisibility(int length) {
    if (length == 1) {
      return true;
    } else if (controller.value >= 0.8) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final reversedList = List.of(notifications);
    reversedList.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    // final updatedNotifications = List.of(notifications);
    // updatedNotifications.removeAt(0);
    return Visibility(
      visible: _getListVisibility(reversedList.length),
      child: Column(
        key: ValueKey('FinalColumn'),
        children: [
          ...reversedList.map(
            (notification) {
              final index = reversedList.indexOf(notification);
              return Slidable(
                actionPane: SlidableBehindActionPane(),
                secondaryActions: [
                  SlidButton(
                    padding: EdgeInsets.fromLTRB(
                      tilePadding,
                      spacing,
                      0,
                      _getEndPadding(index),
                    ),
                    color: tileColor,
                    shadow: shadow,
                    height: containerHeight,
                    child: view,
                    onTapButton: () {
                      onTapViewCallback(index);
                    },
                    leftCornerRadius: cornerRadius,
                    rightCornerRadius: cornerRadius,
                  ),
                  SlidButton(
                    padding: EdgeInsets.fromLTRB(
                      tilePadding,
                      spacing,
                      0,
                      _getEndPadding(index),
                    ),
                    color: tileColor,
                    shadow: shadow,
                    height: containerHeight,
                    child: clear,
                    onTapButton: () {
                      onTapClearCallback(index);
                    },
                    rightCornerRadius: cornerRadius,
                    leftCornerRadius: cornerRadius,
                  ),
                ],
                child: NotificationTile(
                  heading: type,
                  dateTime: notification.dateTime,
                  title: notification.title,
                  subtitle: notification.subtitle,
                  spacing: spacing,
                  height: containerHeight,
                  color: tileColor,
                  cornerRadius: cornerRadius,
                  titleTextStyle: titleTextStyle,
                  subtitleTextStyle: subtitleTextStyle,
                  shadow: shadow,
                  padding: EdgeInsets.fromLTRB(
                    0,
                    _topPadding(index),
                    0,
                    _getEndPadding(index),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
