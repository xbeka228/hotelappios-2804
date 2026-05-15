import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hotel_app/main.dart';

void main() {
  testWidgets('Hotel app role selection smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const HotelApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('KZ'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(2));

    await tester.tap(find.text('KZ'));
    await tester.pump();
    expect(find.text('RU'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton).last);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
  });
}
