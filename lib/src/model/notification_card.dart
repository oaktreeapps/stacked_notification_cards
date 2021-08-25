import 'package:flutter/material.dart';

class NotificationCard {
  final DateTime dateTime;
  final IconData leadingIcon;
  final double iconSize;
  final String title;
  final String subtitle;

  NotificationCard({
    required this.dateTime,
    required this.leadingIcon,
    required this.iconSize,
    required this.title,
    required this.subtitle,
  });
}
