// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/stacked_notification_cards.dart';
import 'widget_structure.dart';

void main() {
  testWidgets('Expecting default values.', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(StackedNotificationCards(
      cardColor: Colors.white,
      notifications: [],
    ));

    expect(
        tester
            .widget<StackedNotificationCards>(
                find.byType(StackedNotificationCards))
            .cardsSpacing,
        10);

    expect(
        tester
            .widget<StackedNotificationCards>(
                find.byType(StackedNotificationCards))
            .cornerRadius,
        8);

    expect(
        tester
            .widget<StackedNotificationCards>(
                find.byType(StackedNotificationCards))
            .padding,
        0);
  });

  testWidgets('Expecting sizedBox when empty list',
      (WidgetTester tester) async {
    await tester.pumpWidget(WidgetStructure(
      child: StackedNotificationCards(
        cardColor: Colors.white,
        notifications: [],
      ),
    ));

    final Finder sizedBox = find.byKey(ValueKey('EmptySizedBox'));

    expect(sizedBox, findsOneWidget);
  });

  testWidgets('Expecting BuildStackedNotification when the list is not empty.',
      (WidgetTester tester) async {
    await tester.pumpWidget(WidgetStructure(
      child: StackedNotificationCards(
        cardColor: Colors.white,
        notifications: [
          NotificationCard(
              dateTime: DateTime.now(),
              leadingIcon: Icons.account_circle,
              iconSize: 48,
              title: 'OakTree 1',
              subtitle: 'We believe in the power of mobile computing.')
        ],
      ),
    ));

    final Finder buildStackedNotification = find.byKey(
      ValueKey('BuildStackedNotification'),
    );

    expect(buildStackedNotification, findsOneWidget);
  });

  testWidgets('Ticker has been disposed.', (WidgetTester tester) async {
    await tester.pumpWidget(WidgetStructure(
      child: StackedNotificationCards(
        cardColor: Colors.white,
        notifications: [
          NotificationCard(
            dateTime: DateTime.now(),
            leadingIcon: Icons.account_circle,
            iconSize: 48,
            title: 'OakTree 1',
            subtitle: 'We believe in the power of mobile computing.',
          )
        ],
      ),
    ));

    tester.verifyTickersWereDisposed();
  });

  testWidgets('Showing header', (WidgetTester tester) async {
    await tester.pumpWidget(WidgetStructure(
      child: StackedNotificationCards(
        cardColor: Colors.white,
        notifications: [
          NotificationCard(
              dateTime: DateTime.now(),
              leadingIcon: Icons.account_circle,
              iconSize: 48,
              title: 'OakTree 1',
              subtitle: 'We believe in the power of mobile computing.'),
        ],
      ),
    ));

    final Finder notificationTile = find.byKey(
      ValueKey('Header'),
    );

    expect(notificationTile, findsOneWidget);
  });

  testWidgets('Show notification tile when there is one notification',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      WidgetStructure(
        child: StackedNotificationCards(
          cardColor: Colors.white,
          notifications: [
            NotificationCard(
                dateTime: DateTime.now(),
                leadingIcon: Icons.account_circle,
                iconSize: 48,
                title: 'OakTree 1',
                subtitle: 'We believe in the power of mobile computing.'),
          ],
        ),
      ),
    );

    final Finder notificationTile = find.byKey(
      ValueKey('NotificationTile'),
    );

    expect(notificationTile, findsOneWidget);
  });

  testWidgets('Show CollapsedCards when there are more than one notification',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      WidgetStructure(
        child: StackedNotificationCards(
          cardColor: Colors.white,
          notifications: [
            NotificationCard(
              dateTime: DateTime.now(),
              leadingIcon: Icons.account_circle,
              iconSize: 48,
              title: 'OakTree 1',
              subtitle: 'We believe in the power of mobile computing.',
            ),
            NotificationCard(
              dateTime: DateTime.now().subtract(const Duration(minutes: 4)),
              leadingIcon: Icons.account_circle,
              iconSize: 48,
              title: 'OakTree 2',
              subtitle: 'We believe in the power of mobile computing.',
            ),
          ],
        ),
      ),
    );

  

    final Finder collapsedCards = find.byKey(
      ValueKey('CollapsedCards'),
    );

    expect(collapsedCards, findsOneWidget);
  });
}
