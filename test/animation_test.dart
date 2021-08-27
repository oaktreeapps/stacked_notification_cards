import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'data_source.dart';
import 'widget_structure.dart';
import '../lib/stacked_notification_cards.dart';

void main() {
  testWidgets(
      'Show animated offset list initially then disappear when tapped on more notification.',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      BaseStructure(
        list: dataList3,
        // child: StackedNotificationCards(
        //   cardColor: Colors.white,
        //   notifications: dataList3,
        //   clearAll:  Container(),

        // ),
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
      BaseStructure(
        list: dataList3,
        // child: StackedNotificationCards(
        //   cardColor: Colors.white,
        //   notifications: dataList3,
        // ),
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
      BaseStructure(
        list: dataList3,
        // child: StackedNotificationCards(
        //   cardColor: Colors.white,
        //   notifications: dataList3,
        // ),
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
