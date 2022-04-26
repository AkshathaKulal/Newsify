import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newsify_demo/core/utils/constants.dart';
import 'package:newsify_demo/features/news/presentation/pages/dashboard_screen.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DashboardScreen());

    // Verify that our counter starts at 0.
    expect(find.text(Constants.APP_NAME), findsOneWidget);
    expect(find.text(Constants.AUTHOR_NAME), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    expect(find.byIcon(Icons.info), findsOneWidget);
    await tester.pump();
  });
}
