import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'data_source.dart';
import 'widget_structure.dart';

void main() {
  testWidgets('Show last notification card initially then disappear',
      (WidgetTester tester) async {
    await tester.pumpWidget(BaseStructure(
      list: dataList3,
    ));

    final Finder lastNotificationCard = find.byKey(
      ValueKey('LastNotificationCard'),
    );
    expect(lastNotificationCard, findsOneWidget);

    await tester.tap(find.byKey(
      ValueKey('onTapExpand'),
    ));
    await tester.pumpAndSettle();
    expect(lastNotificationCard, findsNothing);
  });

  testWidgets('Does\'t show if there is one notification.',
      (WidgetTester tester) async {
    await tester.pumpWidget(BaseStructure(
      list: dataList1,
    ));

    final Finder lastNotificationCard = find.byKey(
      ValueKey('LastNotificationCard'),
    );
  
    expect(lastNotificationCard, findsNothing);
  });
}
