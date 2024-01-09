import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../model/notification_card.dart';

/// [LastNotificationCard] is the topmost card on the stack

class LastNotificationCard extends StatelessWidget {
  final AnimationController controller;
  final NotificationCard notification;
  final int totalCount;
  final double cornerRadius;
  final Color color;
  final double height;
  final String notificationCardTitle;
  final TextStyle titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final List<BoxShadow>? boxShadow;
  final double padding;
  final String lastNotificationText;
  final bool notificationCounter;
  final String dateText;

  const LastNotificationCard({
    Key? key,
    required this.controller,
    required this.notification,
    required this.totalCount,
    required this.color,
    required this.cornerRadius,
    required this.height,
    required this.notificationCardTitle,
    required this.subtitleTextStyle,
    required this.titleTextStyle,
    required this.boxShadow,
    required this.padding,
    required this.lastNotificationText,
    required this.notificationCounter,
    required this.dateText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: totalCount > 1 && controller.value <= 0.4,
      child: GestureDetector(
        key: ValueKey('onTapExpand'),
        onTap: () {
          Slidable.of(context)?.close();
          controller.forward();
        },
        child: Container(
          key: ValueKey('LastNotificationCard'),
          margin: EdgeInsets.symmetric(horizontal: padding),
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(cornerRadius),
            boxShadow: boxShadow,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Opacity(
                  opacity: Tween(begin: 0.0, end: 1.0)
                      .animate(
                        CurvedAnimation(
                          parent: controller,
                          curve: Interval(0.2, 0.3),
                        ),
                      )
                      .value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notificationCardTitle,
                          style: kCardTopTextStyle,
                          maxLines: 1,
                        ),
                      ),
                      Text(
                        dateText +
                            ' ${DateFormat('h:mm a').format(notification.date)}',
                        style: kCardTopTextStyle,
                      )
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: Tween<Offset>(
                  begin: Offset(0, 15),
                  end: Offset(0, 10),
                )
                    .animate(
                      CurvedAnimation(
                        parent: controller,
                        curve: Interval(0.0, 0.2),
                      ),
                    )
                    .value,
                child: Visibility(
                  visible: controller.value <= 0.2,
                  child: ListTile(
                    leading: notification.leading,
                    title: Text(
                      notification.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleTextStyle,
                    ),
                    subtitle: Text(
                      notification.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: subtitleTextStyle,
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Tween<Offset>(
                  begin: Offset(0, 10),
                  end: Offset(0, 50),
                )
                    .animate(
                      CurvedAnimation(
                        parent: controller,
                        curve: Interval(0.2, 0.4),
                      ),
                    )
                    .value,
                child: Visibility(
                  visible: controller.value >= 0.2,
                  child: ListTile(
                    leading: notification.leading,
                    title: Text(
                      notification.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleTextStyle,
                    ),
                    subtitle: Text(
                      notification.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: subtitleTextStyle,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                child: Opacity(
                  opacity: Tween(begin: 1.0, end: 0.0)
                      .animate(
                        CurvedAnimation(
                          parent: controller,
                          curve: Interval(0.0, 0.2),
                        ),
                      )
                      .value,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 4.0,
                      ),
                      child: notificationCounter
                          ? Text(
                              '${totalCount - 1} ' + lastNotificationText,
                              style: TextStyle(fontSize: 16),
                            )
                          : Text(
                              lastNotificationText,
                              style: TextStyle(fontSize: 16),
                            )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
