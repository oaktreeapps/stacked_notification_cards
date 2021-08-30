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
  final String type;
  final TextStyle titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final List<BoxShadow>? shadow;
  final bool slidableOpened;

  const LastNotificationCard({
    Key? key,
    required this.controller,
    required this.notification,
    required this.totalCount,
    required this.onTapExpand,
    required this.color,
    required this.cornerRadius,
    required this.height,
    required this.type,
    required this.subtitleTextStyle,
    required this.titleTextStyle,
    required this.shadow,
    required this.slidableOpened,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: totalCount > 1 && controller.value <= 0.4,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(cornerRadius),
          boxShadow: shadow,
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
                    Expanded(
                      child: Text(
                        type,
                        style: kCardTopTextStyle,
                        maxLines: 1,
                      ),
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
                  leading: Icon(
                    Icons.account_circle,
                    size: 48,
                  ),
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
              child: MoreNotificationButton(
                key: ValueKey('MoreNotificationButton'),
                controller: controller,
                onTapExpand: onTapExpand,
                totalCount: totalCount,
                slidableOpened: slidableOpened,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoreNotificationButton extends StatelessWidget {
  final VoidCallback onTapExpand;
  final AnimationController controller;
  final int totalCount;
  final bool slidableOpened;
  const MoreNotificationButton({
    Key? key,
    required this.onTapExpand,
    required this.controller,
    required this.totalCount,
    required this.slidableOpened,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: slidableOpened == true ? null : onTapExpand,
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
