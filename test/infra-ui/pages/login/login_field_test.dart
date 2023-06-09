import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_traders/domain/agent/agent.dart';
import 'package:space_traders/infra-ui/adapters.dart';
import 'package:space_traders/infra-ui/pages/home/home.dart';
import 'package:space_traders/infra-ui/pages/login/login_field.dart';

import '../../../mocks/agent.inMemory.dart';
import '../../../setup_test.dart';

void main() {
  setUp(registerAllInMemoryAdapters);
  group("Login flow", () {
    group("Submit behavior", () {
      testWidgets("it should save token on button tap", (tester) async {
        // Given
        final tokenInput = find.byType(TextField);
        final submitButton = find.byTooltip("Log in");

        var given = "My great token";
        var actual = "";

        Adapters.saveTokenAdapter = (token) {
          actual = token;
        };

        await tester.pumpWidget(const TestApp(
          testing: Material(child: LoginField()),
        ));

        // When
        await tester.enterText(tokenInput, given);
        await tester.tap(submitButton);
        await tester.pumpAndSettle();
        // Expect
        expect(actual, equals(given));
      });

      testWidgets("it should save token on input submit", (tester) async {
        final tokenInput = find.byType(TextField);
        var given = "My great token";
        var actual = "";

        Adapters.saveTokenAdapter = (token) {
          actual = token;
        };

        await tester.pumpWidget(const TestApp(
          testing: Material(child: LoginField()),
        ));

        await tester.enterText(tokenInput, given);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(actual, equals(given));
      });
    });

    group("Validate token with API", () {
      Future<void> login(WidgetTester tester) async {
        final tokenInput = find.byType(TextField);
        final submitButton = find.byTooltip("Log in");
        Adapters.saveTokenAdapter = (token) {/* noop */};

        // When
        await tester.enterText(tokenInput, "My great token");
        await tester.tap(submitButton);
        await tester.pumpAndSettle();
      }

      testWidgets("it should navigate to home view on success", (tester) async {
        // Given
        await tester.pumpWidget(const TestApp(
          testing: Material(child: LoginField()),
        ));
        // When
        await login(tester);

        expect(find.byType(HomePage), findsOneWidget);
      });

      testWidgets("it should display error on failure", (tester) async {
        // Given
        String errorMessage = "Invalid token";
        Adapters.agentAdapter = InMemoryAgentAdapterThatThrow(errorMessage);
        await tester.pumpWidget(const TestApp(
          testing: Material(child: LoginField()),
        ));
        // When
        await login(tester);

        expect(find.byType(HomePage), findsNothing);
        expect(find.textContaining(errorMessage), findsOneWidget);
      });
    });
  });
}

class InMemoryAgentAdapterThatThrow extends AgentInMemoryAdapter {
  final String error;
  InMemoryAgentAdapterThatThrow(this.error);

  @override
  Future<Agent> getMe() => super.getMe().then((value) => throw error);
}
