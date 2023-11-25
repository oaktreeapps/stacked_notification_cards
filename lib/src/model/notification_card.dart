import 'package:flutter/material.dart';

class NotificationCard {
  final DateTime date;
  final String title;
  final String subtitle;
  final Widget? leading;

  const NotificationCard({
    required this.date,
    required this.title,
    required this.subtitle,
    this.leading,
  });
}
