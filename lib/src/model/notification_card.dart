import 'package:flutter/material.dart';

class NotificationCard {
  final DateTime date;
  final Widget? leading;
  final String title;
  final String subtitle;
  final String? format;

  const NotificationCard({
    required this.date,
    required this.title,
    required this.subtitle,
    this.leading,
    this.format,
  });
}
