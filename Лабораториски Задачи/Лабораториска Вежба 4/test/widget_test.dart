// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lab4/main.dart'; 

void main() {
  testWidgets('Exam schedule smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ExamScheduleApp()); // Користи ја точната класа

    // Verify that the app shows the calendar widget.
    expect(find.byType(TableCalendar), findsOneWidget);

    // Verify the app bar title.
    expect(find.text('Exam Schedule'), findsOneWidget);

    // Select a specific date and verify events.
    await tester.tap(find.text('10')); // Example: Select January 10
    await tester.pump();

    expect(find.text('Math Exam'), findsOneWidget);
    expect(find.text('Physics Exam'), findsNothing);
  });
}

