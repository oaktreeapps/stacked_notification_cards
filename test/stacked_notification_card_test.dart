// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/stacked_notification_cards.dart';
import 'data_source.dart';
import 'widget_structure.dart';

void main() {
  testWidgets('Expecting default values.', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BaseStructure(
      list: [],
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
            .cardCornerRadius,
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
    await tester.pumpWidget(BaseStructure(
      list: [],
    ));

    final Finder sizedBox = find.byKey(ValueKey('EmptySizedBox'));

    expect(sizedBox, findsOneWidget);
  });

  testWidgets('Expecting BuildStackedNotification when the list is not empty.',
      (WidgetTester tester) async {
    await tester.pumpWidget(BaseStructure(
      list: dataList1,
    ));

    final Finder buildStackedNotification = find.byKey(
      ValueKey('Message'),
    );

    expect(buildStackedNotification, findsOneWidget);
  });

  testWidgets('Ticker has been disposed.', (WidgetTester tester) async {
    await tester.pumpWidget(BaseStructure(list: dataList1));

    tester.verifyTickersWereDisposed();
  });

  testWidgets('Showing header', (WidgetTester tester) async {
    await tester.pumpWidget(BaseStructure(
      list: dataList1,
    ));

    final Finder notificationTile = find.byKey(
      ValueKey('Header'),
    );

    expect(notificationTile, findsOneWidget);
  });

}
