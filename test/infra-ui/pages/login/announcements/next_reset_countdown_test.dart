import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_traders/domain/server_status.dart';
import 'package:space_traders/infra-ui/adapters.dart';
import 'package:space_traders/infra-ui/pages/login/annoucements/announcements.dart';

import '../../../../mocks/server.inMemory.dart';

void main() {
  group("Annoucements", () {
    testWidgets('should show next reset', (WidgetTester tester) async {
      Adapters.serverAdapter = InMemoryAdapterWithResetInFewDays();
      await tester.pumpWidget(const MaterialApp(home: Announcements()));

      final announcementsButton = find.text('Announcements');
      expect(announcementsButton, findsOneWidget);

      await tester.tap(announcementsButton);
      await tester.pumpAndSettle();

      expect(
        find.textContaining(RegExp(
            r'Next reset in \d days and (\d+ hours )?(\d+ min )?(\d+ s)?')),
        findsOneWidget,
      );
    });
  });
}

class InMemoryAdapterWithResetInFewDays extends ServerInMemoryAdapter {
  @override
  Future<ServerStatus> getStatus() => super.getStatus().then((value) =>
      value.copyWith(nextReset: DateTime.now().add(const Duration(days: 5))));
}
