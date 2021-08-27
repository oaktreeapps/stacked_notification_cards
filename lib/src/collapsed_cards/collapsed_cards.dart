import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../expanded_list/animated_offset_list.dart';

import 'stacked_container.dart';
import 'last_notification_card.dart';
import '../model/notification_card.dart';
import '../notification_tile/notification_tile.dart';
import '../notification_tile/slid_button.dart';
import '../expanded_list/expanded_list.dart';

class CollapsedCards extends StatefulWidget {
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

  CollapsedCards({
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
  }) : super(key: key);

  @override
  _CollapsedCardsState createState() => _CollapsedCardsState();
}

class _CollapsedCardsState extends State<CollapsedCards> {
  late SlidableController slidableController;

  bool? slidableOpened = false;

  @override
  void initState() {
    super.initState();
    slidableController = SlidableController(
      onSlideIsOpenChanged: (value) {
        setState(() {
          slidableOpened = value;
        });
      },
      onSlideAnimationChanged: (value) {},
    );
  }

  double getBaseHeight() {
    final length = widget.notifications.length;
    if (length == 1)
      return 0;
    else if (length == 2)
      return widget.spacing;
    else
      return 2 * widget.spacing;
  }

  @override
  Widget build(BuildContext context) {
    final lastNotification = widget.notifications.first;

    final controller = widget.controller;
    final notifications = widget.notifications;
    final containerHeight = widget.containerHeight;
    final spacing = widget.spacing;
    final onTapShowMore = widget.onTapShowMore;
    final isExpaned = widget.isExpaned;
    final maxSpacing = widget.maxSpacing;
    final containerColor = widget.containerColor;
    final cornerRadius = widget.cornerRadius;
    final padding = widget.padding;
    final type = widget.type;
    final titleTextStyle = widget.titleTextStyle;
    final subtitleTextStyle = widget.subtitleTextStyle;
    final shadow = widget.shadow;
    final onTapClearAll = widget.onTapClearAll;
    final clearAll = widget.clearAll;
    final view = widget.view;
    final clear = widget.clear;
    final onTapClear = widget.onTapClearCallback;
    final onTapView = widget.onTapViewCallback;

    final index = notifications.length - 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Slidable(
        controller: slidableController,
        actionPane: SlidableBehindActionPane(),
        secondaryActions: [
          Align(
            alignment: Alignment.topCenter,
            child: SlidButton(
              padding: EdgeInsets.only(
                left: padding,
              ),
              color: containerColor,
              height: containerHeight,
              leftCornerRadius: cornerRadius,
              rightCornerRadius: cornerRadius,
              shadow: shadow,
              onTapButton: isExpaned ? () => onTapView(index) : onTapClearAll,
              child: isExpaned ? view : clearAll,
            ),
          ),
          if (isExpaned)
            SlidButton(
                padding: EdgeInsets.only(
                  left: padding,
                ),
                color: containerColor,
                height: containerHeight,
                leftCornerRadius: cornerRadius,
                rightCornerRadius: cornerRadius,
                shadow: shadow,
                onTapButton: () => onTapClear(index),
                child: clear)
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
                shadow: shadow,
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
                shadow: shadow,
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
                type: type,
                controller: controller,
                interval: Interval(0.4, 0.8),
                notifications: notifications,
                height: containerHeight,
                spacing: maxSpacing,
                cornerRadius: cornerRadius,
                tileColor: containerColor,
                titleTextStyle: titleTextStyle,
                subtitleTextStyle: subtitleTextStyle,
                shadow: shadow,
              ),
            ),
            Visibility(
              visible: !isExpaned,
              child: LastNotificationCard(
                type: type,
                controller: controller,
                notification: lastNotification,
                totalCount: notifications.length,
                onTapExpand: onTapShowMore,
                height: containerHeight,
                color: containerColor,
                cornerRadius: cornerRadius,
                titleTextStyle: titleTextStyle,
                subtitleTextStyle: subtitleTextStyle,
                shadow: shadow,
                slidableOpened: slidableOpened ?? false,
              ),
            ),
            Visibility(
              visible: isExpaned,
              child: NotificationTile(
                heading: type,
                dateTime: lastNotification.dateTime,
                title: lastNotification.title,
                subtitle: lastNotification.subtitle,
                height: containerHeight,
                cornerRadius: cornerRadius,
                color: containerColor, titleTextStyle: titleTextStyle,
                subtitleTextStyle: subtitleTextStyle, shadow: shadow,
                // padding: ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
