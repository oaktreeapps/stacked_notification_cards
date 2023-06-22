import 'package:flutter/material.dart';
import '../lib/stacked_notification_cards.dart';

class BaseStructure extends StatelessWidget {
  // final Widget child;
  final List<NotificationCard> list;
  const BaseStructure({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: StackedNotificationCards(
        cardColor: Colors.white,
        notificationCards: list,
        notificationCardTitle: 'Message',
        onTapClearAll: () {},
        clearAllStacked: Text('Clear All'),
        clearAllNotificationsAction: Icon(Icons.close),
        cardClearButton: Text('clear'),
        cardViewButton: Text('view'),
        showLessAction: Text(''),
        actionTitle: Text(''),
        onTapClearCallback: (index) {},
        onTapViewCallback: (index) {},
      ),
    ));
  }
}
