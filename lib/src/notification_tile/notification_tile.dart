import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

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


  const NotificationTile({
    Key? key,
    required this.title,
    required this.heading,
    required this.dateTime,
    required this.subtitle,
    required this.height,
    required this.cornerRadius,
    required this.color,

    this.spacing = 0,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableBehindActionPane(),
      secondaryActions: [
        Container(
          margin: EdgeInsets.fromLTRB(8, spacing, 0, 0),
          alignment: Alignment.center,
          child: Text('View'),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            // color: color,
            border: Border.all(
              color: Colors.black.withOpacity(0.2),
              width: 1.4,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(8, spacing, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.black.withOpacity(0.2),
              width: 1.4,
            ),
          ),
          child: Text('Clear'),
        ),
      ],
      child: Container(
        margin: padding,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(cornerRadius),
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
                  Text(
                    heading,
                    style: kCardTopTextStyle,
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
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(subtitle),
            ),
          ],
        ),
      ),
    );
  }
}
