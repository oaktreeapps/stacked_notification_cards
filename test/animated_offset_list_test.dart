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

    final Finder animatedOffsetList = find.byKey(
      ValueKey('AnimatedOffsetList'),
    );
    expect(animatedOffsetList, findsOneWidget);

    await tester.tap(find.byKey(
     ValueKey('onTapExpand'),
    ));
    await tester.pumpAndSettle();
    expect(animatedOffsetList, findsNothing);
  });

  testWidgets('Does\'t show if there is one notification.',
      (WidgetTester tester) async {
    await tester.pumpWidget(BaseStructure(
      list: dataList1,
    ));

    final Finder animatedOffsetList = find.byKey(
      ValueKey('AnimatedOffsetList'),
    );
    expect(animatedOffsetList, findsNothing);
  });
}
