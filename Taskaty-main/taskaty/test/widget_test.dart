// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:taskaty/main.dart';

void main() {
  testWidgets('Taskaty app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TaskatyApp());

    // Verify that our app shows the Taskaty title.
    expect(find.text('Taskati'), findsOneWidget);
    expect(find.text('It\'s time to be organized!'), findsOneWidget);

    // Wait for the splash screen to complete and navigate to upload screen.
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verify that we're now on the upload screen.
    expect(find.text('Upload From Camera'), findsOneWidget);
    expect(find.text('Upload From Gallery'), findsOneWidget);
    expect(find.text('Enter your name'), findsOneWidget);
  });
}
