import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../expanded_list/animated_offset_list.dart';

import 'stacked_container.dart';
import 'last_notification_card.dart';
import '../model/notification_card.dart';
import '../notification_tile/notification_tile.dart';

class CollapsedCards extends StatelessWidget {
  final AnimationController controller;
  final List<NotificationCard> notifications;
  final double containerHeight;
  final double spacing;
  final double maxSpacing;
  final VoidCallback onTapShowMore;
  final bool isExpaned;
  final Color containerColor;
  final double cornerRadius;
  final double padding;

  const CollapsedCards({
    Key? key,
    required this.controller,
    required this.notifications,
    required this.containerHeight,
    required this.spacing,
    required this.onTapShowMore,
    required this.isExpaned,
    required this.maxSpacing,
    required this.containerColor,
    required this.cornerRadius,
    required this.padding,
  }) : super(key: key);

  double getBaseHeight() {
    final length = notifications.length;
    if (length == 1)
      return 0;
    else if (length == 2)
      return spacing;
    else
      return 2 * spacing;
  }

  @override
  Widget build(BuildContext context) {
    final lastNotification = notifications.first;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Slidable(
        actionPane: SlidableBehindActionPane(),
        secondaryActions: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(
                left: 8,
              ),
              height: containerHeight,
              alignment: Alignment.center,
              child: Text('Clear All'),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.black.withOpacity(0.2),
                  width: 1.4,
                ),
              ),
            ),
          ),
        ],
        child: Stack(
          children: [
            Visibility(
              visible: controller.value <= 0.4,
              child: Container(
                height: containerHeight + getBaseHeight(),
              ),
            ),
            Visibility(
              visible: notifications.length > 2,
              child: StackedContainer(
                key: ValueKey('StackedContainer'),
                horizontalPadding: 2 * spacing,
                color: containerColor,
                controller: controller,
                height: containerHeight,
                offset: 2 * spacing,
                cornerRadius: cornerRadius,
                shadeColor: Colors.black.withOpacity(0.1),
              ),
            ),
            Visibility(
              visible: notifications.length > 1,
              child: StackedContainer(
                horizontalPadding: spacing,
                color: containerColor,
                controller: controller,
                height: containerHeight,
                offset: spacing,
                cornerRadius: cornerRadius,
                shadeColor: Colors.black.withOpacity(0.05),
              ),
            ),
            Visibility(
              visible: controller.value <= 0.8,
              child: AnimatedOffsetList(
                key: ValueKey('AnimatedOffsetList'),
                controller: controller,
                interval: Interval(0.4, 0.8),
                notifications: notifications,
                height: containerHeight,
                spacing: maxSpacing,
                cornerRadius: cornerRadius,
                tileColor: containerColor,
              ),
            ),
            Visibility(
              visible: !isExpaned,
              child: LastNotificationCard(
                controller: controller,
                notification: lastNotification,
                totalCount: notifications.length,
                onTapExpand: onTapShowMore,
                height: containerHeight,
                color: containerColor,
                cornerRadius: cornerRadius,
              ),
            ),
            Visibility(
              visible: isExpaned,
              child: NotificationTile(
                heading: 'Message',
                dateTime: lastNotification.dateTime,
                title: lastNotification.title,
                subtitle: lastNotification.subtitle,
                height: containerHeight,
                cornerRadius: cornerRadius,
                color: containerColor,
                // padding: ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SlidButton extends StatelessWidget {
  const SlidButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
