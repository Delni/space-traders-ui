import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_traders/infra-ui/adapters.dart';
import 'package:space_traders/infra-ui/pages/homescreen.dart';

import '../../mocks/server.inMemory.dart';

void main() {
  group("Home screen", () {
    testWidgets('should state game\'s name', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.text('Space Traders'), findsOneWidget);
    });

    testWidgets('should allow to login', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      expect(find.text("Enter your token to connect"), findsOneWidget);
    });

    testWidgets('should show announcements', (WidgetTester tester) async {
      Adapters.serverAdapter = ServerInMemoryAdapter();
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      final announcementsButton = find.text('Announcements');
      expect(announcementsButton, findsOneWidget);

      await tester.tap(announcementsButton);
      await tester.pumpAndSettle();

      expect(find.text("Test Announcement"), findsOneWidget);
    });
  });
}
