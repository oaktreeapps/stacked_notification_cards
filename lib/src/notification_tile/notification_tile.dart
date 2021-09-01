import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

/// This widget is responsible for structuring the [NotificationCard].
class NotificationTile extends StatelessWidget {
  final String cardTitle;
  final DateTime date;
  final String title;
  final String subtitle;
  final EdgeInsets? padding;
  final double height;
  final double spacing;
  final double cornerRadius;
  final Color color;
  final TextStyle titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final List<BoxShadow>? boxShadow;

  const NotificationTile({
    Key? key,
    required this.title,
    required this.cardTitle,
    required this.date,
    required this.subtitle,
    required this.height,
    required this.cornerRadius,
    required this.color,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.boxShadow,
    this.spacing = 0,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(cornerRadius),
        boxShadow: boxShadow,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    cardTitle,
                    style: kCardTopTextStyle,
                    maxLines: 1,
                  ),
                ),
                Text(
                  'Today ${DateFormat('h:mm a').format(date)}',
                  style: kCardTopTextStyle,
                )
              ],
            ),
          ),
          SizedBox(
            height: 17,
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              size: 48,
            ),
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: titleTextStyle,
            ),
            subtitle: Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: subtitleTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
