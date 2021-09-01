import 'package:flutter/material.dart';

class NotificationCard {
  final DateTime date;
  final Widget leading;
  final String title;
  final String subtitle;

  const NotificationCard({
    required this.date,
    required this.leading,
    required this.title,
    required this.subtitle,
  });
}
