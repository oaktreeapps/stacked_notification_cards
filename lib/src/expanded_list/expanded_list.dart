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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double topTilePadding =
        Tween<double>(begin: initialSpacing, end: spacing)
            .animate(
              CurvedAnimation(
                parent: controller,
                curve: Interval(0.8, 1.0),
              ),
            )
            .value;

    final updatedNotifications = List.of(notifications);
    updatedNotifications.removeAt(0);
    return Stack(
      children: [
        Visibility(
          visible: controller.value <= 0.8,
          child: SizedBox(
            key: ValueKey('SpacerSizedBox'),
            height: Tween<double>(
              begin: 0.0,
              end: updatedNotifications.length *
                  (containerHeight + initialSpacing),
            )
                .animate(
                  CurvedAnimation(
                    parent: controller,
                    curve: Interval(0.4, 0.8),
                  ),
                )
                .value,
            // color: Colors.amberAccent.withOpacity(0.2),
          ),
        ),
        Visibility(
          visible: controller.value >= 0.8,
          child: Column(
            key: ValueKey('FinalColumn'),
            children: [
              ...updatedNotifications.map(
                (notification) {
                  final index = updatedNotifications.length -
                      updatedNotifications.indexOf(notification) -
                      1;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: tilePadding),
                    child: Slidable(
                      actionPane: SlidableBehindActionPane(),
                      secondaryActions: [
                        SlidButton(
                          padding:
                              EdgeInsets.fromLTRB(tilePadding, spacing, 0, 0),
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
                          padding:
                              EdgeInsets.fromLTRB(tilePadding, spacing, 0, 0),
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
                          topTilePadding,
                          0,
                          0,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
