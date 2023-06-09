import 'package:flutter_test/flutter_test.dart';
import 'package:space_traders/infra-ui/adapters.dart';
import 'package:space_traders/infra-ui/pages/login/login.dart';

import '../../../mocks/server.inMemory.dart';
import '../../../test_utils.dart';

void main() {
  setUp(registerAllInMemoryAdapters);
  group("Home screen", () {
    testWidgets('should state game\'s name', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp(testing: LoginPage()));

      expect(find.text('Space Traders'), findsOneWidget);
    });

    testWidgets('should allow to login', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp(testing: LoginPage()));

      expect(find.text("Enter your token to connect"), findsOneWidget);
    });

    testWidgets('should show announcements', (WidgetTester tester) async {
      Adapters.serverAdapter = ServerInMemoryAdapter();
      await tester.pumpWidget(const TestApp(testing: LoginPage()));

      final announcementsButton = find.text('Announcements');
      expect(announcementsButton, findsOneWidget);

      await tester.tap(announcementsButton);
      await tester.pumpAndSettle();

      expect(find.text("Test Announcement"), findsOneWidget);
    });
  });
}
