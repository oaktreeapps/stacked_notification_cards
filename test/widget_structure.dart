import 'package:flutter/material.dart';
import '../lib/stacked_notification_cards.dart';
import '../lib/src/model/notification_card.dart';

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
        notifications: list,
        type: 'Message',
        onTapClearAll: () {},
        clearAllStacked: Text('Clear All'),
        headerClearAllButton: Icon(Icons.close),
        clear: Text('clear'),
        view: Text('view'),
        headerShowLess: Text(''),
        headerTitle: Text(''),
        onTapClearCallback: (index) {},
        onTapViewCallback: (index) {},
      ),
    ));
  }
}
