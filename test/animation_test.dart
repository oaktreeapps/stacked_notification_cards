import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_structure.dart';
import '../lib/stacked_notification_cards.dart';
import '../lib/src/expanded_list/animated_offset_list.dart';
import '../lib/src/collapsed_cards/collapsed_cards.dart';

void main() {
  testWidgets(
      'Show animated offset list initially then disappear when tapped on more notification.',
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
            NotificationCard(
              dateTime: DateTime.now().subtract(const Duration(minutes: 10)),
              leadingIcon: Icons.account_circle,
              iconSize: 48,
              title: 'OakTree 3',
              subtitle: 'We believe in the power of mobile computing.',
            ),
          ],
        ),
      ),
    );

    final animatedOffsetList = find.byKey(ValueKey('AnimatedOffsetList'));

    expect(animatedOffsetList, findsOneWidget);

    await tester.tap(find.byKey(ValueKey('MoreNotificationButton')));
    await tester.pumpAndSettle();

    expect(animatedOffsetList, findsNothing);
  });

  testWidgets(
      'Show this sized box to create a fake height, and push any following widget down in the list.',
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
            NotificationCard(
              dateTime: DateTime.now().subtract(const Duration(minutes: 10)),
              leadingIcon: Icons.account_circle,
              iconSize: 48,
              title: 'OakTree 3',
              subtitle: 'We believe in the power of mobile computing.',
            ),
          ],
        ),
      ),
    );

    final spacerSizedBox = find.byKey(
      ValueKey('SpacerSizedBox'),
    );

    expect(spacerSizedBox, findsOneWidget);

    await tester.tap(find.byKey(ValueKey('MoreNotificationButton')));
    await tester.pumpAndSettle();

    expect(spacerSizedBox, findsNothing);
  });

  testWidgets(
      'Show this list at the end of the animation this will be user intractable.',
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
            NotificationCard(
              dateTime: DateTime.now().subtract(const Duration(minutes: 10)),
              leadingIcon: Icons.account_circle,
              iconSize: 48,
              title: 'OakTree 3',
              subtitle: 'We believe in the power of mobile computing.',
            ),
          ],
        ),
      ),
    );

    final finalColumn = find.byKey(
      ValueKey('FinalColumn'),
    );

    expect(finalColumn, findsNothing);

    await tester.tap(find.byKey(ValueKey('MoreNotificationButton')));
    await tester.pumpAndSettle();

    expect(finalColumn, findsOneWidget);
  });
}
