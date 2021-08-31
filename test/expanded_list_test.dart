import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'data_source.dart';
import 'widget_structure.dart';

void main() {
  testWidgets(
      'Initially does\'t show, it shows when tapped on the stacked cards.',
      (WidgetTester tester) async {
    await tester.pumpWidget(BaseStructure(
      list: dataList3,
    ));

    final Finder expandedList = find.byKey(
      ValueKey('ExpandedList'),
    );
    expect(expandedList, findsNothing);

    await tester.tap(find.byKey(
      ValueKey('onTapExpand'),
    ));
    await tester.pumpAndSettle();
    expect(expandedList, findsOneWidget);
  });

  testWidgets('Shows when there is one notification card.',
      (WidgetTester tester) async {
    await tester.pumpWidget(BaseStructure(
      list: dataList1,
    ));

    final Finder expandedList = find.byKey(
      ValueKey('ExpandedList'),
    );

    expect(expandedList, findsOneWidget);
  });
}
