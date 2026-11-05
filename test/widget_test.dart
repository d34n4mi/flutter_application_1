
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dysion/main.dart';

void main() {
  testWidgets('Dysion home screen displays correctly',
      (WidgetTester tester) async {
    // Run the Dysion application.
    await tester.pumpWidget(const MyApp());

    // Check the app title.
    expect(find.text('Dysion'), findsOneWidget);

    // Check the welcome message.
    expect(find.text('Welcome to Dysion!'), findsOneWidget);

    // Check the study schedule section.
    expect(find.text('Your Study Schedule'), findsOneWidget);

    // Check the empty schedule message.
    expect(
      find.text('No study schedules yet.\nAdd your first schedule!'),
      findsOneWidget,
    );

    // Check the Add Schedule button.
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
