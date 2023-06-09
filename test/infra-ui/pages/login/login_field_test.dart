import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_traders/infra-ui/adapters.dart';
import 'package:space_traders/infra-ui/pages/login/login_field.dart';

void main() {
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

        await tester.pumpWidget(MaterialApp(
          home: Material(child: LoginField()),
        ));

        // When
        await tester.enterText(tokenInput, given);
        await tester.tap(submitButton);

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

        await tester.pumpWidget(MaterialApp(
          home: Material(child: LoginField()),
        ));

        await tester.enterText(tokenInput, given);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        expect(actual, equals(given));
      });
    });
  });
}