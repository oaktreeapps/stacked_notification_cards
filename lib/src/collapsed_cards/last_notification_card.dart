import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../model/notification_card.dart';

class LastNotificationCard extends StatelessWidget {
  final AnimationController controller;
  final NotificationCard notification;
  final int totalCount;
  final VoidCallback onTapExpand;
  final double cornerRadius;
  final Color color;
  final double height;

  const LastNotificationCard({
    Key? key,
    required this.controller,
    required this.notification,
    required this.totalCount,
    required this.onTapExpand,
    required this.color,
    required this.cornerRadius,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(cornerRadius),
        // border: Border.all(
        //   color: Colors.black.withOpacity(0.2),
        //   width: 1.4,
        // ),
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
                  Text(
                    'Message',
                    style: kCardTopTextStyle,
                  ),
                  Text(
                    'Today ${DateFormat('h:mm a').format(notification.dateTime)}',
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
                leading: Icon(
                  Icons.account_circle,
                  size: 48,
                ),
                title: Text(
                  notification.title,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(notification.subtitle),
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
                leading: Icon(
                  Icons.account_circle,
                  size: 48,
                ),
                title: Text(
                  notification.title,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(notification.subtitle),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            child: MoreNotificationButton(

              key: ValueKey('MoreNotificationButton'),
              controller: controller,
              onTapExpand: onTapExpand,
              totalCount: totalCount,
            ),
          ),
        ],
      ),
    );
  }
}

class MoreNotificationButton extends StatelessWidget {
  final VoidCallback onTapExpand;
  final AnimationController controller;
  final int totalCount;
  const MoreNotificationButton(
      {Key? key,
      required this.onTapExpand,
      required this.controller,
      required this.totalCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapExpand,
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
          child: Text(
            '${totalCount - 1} more notification',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
