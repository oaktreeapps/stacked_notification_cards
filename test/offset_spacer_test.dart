import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'data_source.dart';
import 'widget_structure.dart';


void main() {
  testWidgets('Show when cards are collapsed and animate.',
      (WidgetTester tester) async {
    await tester.pumpWidget(BaseStructure(
      list: dataList3,
    ));

    final Finder offsetSpacer = find.byKey(ValueKey('SpacerSizedBox'));
    expect(offsetSpacer, findsOneWidget);

    await tester.tap(find.byKey(ValueKey('onTapExpand')));
    await tester.pumpAndSettle();
    expect(offsetSpacer, findsNothing);
  });
}
