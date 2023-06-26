import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_traders/domain/faction.dart';
import 'package:space_traders/infra-ui/adapters.dart';
import 'package:space_traders/infra-ui/pages/login/sign_up.dart';

import '../../../mocks/server.inMemory.dart';
import '../../../test_utils.dart';

void main() {
  group("Sign up", () {
    testWidgets("should allow to create an account", (tester) async {
      // Given
      final agentSymbolField = find.ancestor(
        of: find.text("Agent's name"),
        matching: find.byType(TextField),
      );
      Adapters.serverAdapter = InMemoryServerAdapterThatSignIn();

      final List<MethodCall> log = <MethodCall>[];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform, (MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });

      await tester.pumpWidget(const TestApp(testing: SignUp()));
      // 1. Show modal route
      await tester.tap(find.textContaining("No token?"));
      await tester.pumpAndSettle();

      // 2. Enter agent's name
      expect(agentSymbolField, findsOneWidget);
      await tester.enterText(agentSymbolField, "My Test Agent");

      // 3. Get token in clipboard
      await tester.tap(find.text("Register"));
      await tester.pumpAndSettle();

      expect(find.text("token"), findsOneWidget);
      await tester.tap(find.byTooltip("Copy to clipboard"));
      await tester.pumpAndSettle();

      expect(log.map((e) => e.method), contains('Clipboard.setData'));
      expect(log.map((e) => e.arguments), contains(equals({'text': 'token'})));
    });

    testWidgets("should display error on agent already claimed",
        (tester) async {
      // Given
      Adapters.serverAdapter = InMemoryServerAdapterThatRejectAgent();
      // When
      // Expect
    }, skip: true);
  });
}

class InMemoryServerAdapterThatSignIn extends ServerInMemoryAdapter {
  @override
  Future<String> register(String agentName, Faction faction) =>
      Future.value("token");
}

class InMemoryServerAdapterThatRejectAgent extends ServerInMemoryAdapter {
  @override
  Future<String> register(String agentName, Faction faction) =>
      Future.error("Agent with name $agentName already exists");
}
