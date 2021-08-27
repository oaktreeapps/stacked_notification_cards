import 'package:flutter/material.dart';

class NotificationCard {
  final DateTime dateTime;
  final Widget leading;
  final String title;
  final String subtitle;

  const NotificationCard({
    required this.dateTime,
    required this.leading,
    required this.title,
    required this.subtitle,
  });
}
