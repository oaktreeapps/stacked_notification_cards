import 'package:flutter/material.dart';
import 'package:stacked_notification_cards/stacked_notification_cards.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<NotificationCard> _listOfNotification = [
    NotificationCard(
        dateTime: DateTime.now(),
        leadingIcon: Icons.account_circle,
        iconSize: 48,
        title: 'OakTree 1',
        subtitle: 'We believe in the power of mobile computing.'),
    NotificationCard(
        dateTime: DateTime.now().subtract(const Duration(minutes: 4)),
        leadingIcon: Icons.account_circle,
        iconSize: 48,
        title: 'OakTree 2',
        subtitle: 'We believe in the power of mobile computing.'),
    NotificationCard(
        dateTime: DateTime.now().subtract(const Duration(minutes: 10)),
        leadingIcon: Icons.account_circle,
        iconSize: 48,
        title: 'OakTree 3',
        subtitle: 'We believe in the power of mobile computing.'),
    NotificationCard(
        dateTime: DateTime.now().subtract(const Duration(minutes: 30)),
        leadingIcon: Icons.account_circle,
        iconSize: 48,
        title: 'OakTree 4',
        subtitle: 'We believe in the power of mobile computing.'),
    NotificationCard(
        dateTime: DateTime.now().subtract(const Duration(minutes: 44)),
        leadingIcon: Icons.account_circle,
        iconSize: 48,
        title: 'OakTree 5',
        subtitle: 'We believe in the power of mobile computing.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Stacked Notification Card'),
      ),
      body: SingleChildScrollView(
        child: StackedNotificationCards(
          notifications: [..._listOfNotification],
          cardColor: Color(0xFFF1F1F1),
          padding: 16,
        ),
      ),
    );
  }
}
