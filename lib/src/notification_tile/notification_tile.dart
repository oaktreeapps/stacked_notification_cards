import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import 'slid_button.dart';

typedef Widget SlidButtonWidgetBuilder(int index);

class NotificationTile extends StatelessWidget {
  final String heading;
  final DateTime dateTime;
  final String title;
  final String subtitle;
  final EdgeInsets? padding;
  final double height;
  final double spacing;
  final double cornerRadius;
  final Color color;
  final TextStyle titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final List<BoxShadow>? shadow;
  // final Widget view;

  // final SlidButtonWidgetBuilder clear;

  const NotificationTile({
    Key? key,
    required this.title,
    required this.heading,
    required this.dateTime,
    required this.subtitle,
    required this.height,
    required this.cornerRadius,
    required this.color,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.shadow,
    // required this.clear,
    // required this.view,
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
        boxShadow: shadow,
        // border: Border.all(
        //   color: Colors.black.withOpacity(0.2),
        //   width: 1.4,
        // ),
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
                    heading,
                    style: kCardTopTextStyle,
                    maxLines: 1,
                  ),
                ),
                Text(
                  'Today ${DateFormat('h:mm a').format(dateTime)}',
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
