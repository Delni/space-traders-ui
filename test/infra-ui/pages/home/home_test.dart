import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/agent/agent.dart';
import 'package:space_traders/infra-ui/pages/home/fleet.dart';
import 'package:space_traders/infra-ui/pages/home/home.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';

import '../../../test_utils.dart';

void main() {
  setUp(registerAllInMemoryAdapters);
  group('Home Page', () {
    Future<void> pumpHomePageWithAgentPreloaded(WidgetTester tester) async {
      final agent = Agent(
        accountId: "accountId",
        symbol: "Starlord",
        headquarters: "headquarters",
        credits: 100,
      );
      await tester.pumpWidget(TestApp(testing: Builder(builder: (context) {
        Provider.of<AgentProvider>(context, listen: false).agent = agent;
        // When
        return const HomePage();
      })));
    }

    testWidgets('should display greetings', (tester) async {
      // Given
      final agent = Agent(
        accountId: "accountId",
        symbol: "Starlord",
        headquarters: "headquarters",
        credits: 100,
      );
      await tester.pumpWidget(TestApp(testing: Builder(builder: (context) {
        Provider.of<AgentProvider>(context, listen: false).agent = agent;
        // When
        return const HomePage();
      })));
      // Expect
      expect(find.text("Greetings Starlord"), findsOneWidget);
      expect(find.text("100c"), findsOneWidget);
    });

    testWidgets('should display the fleet', (tester) async {
      // Given
      await pumpHomePageWithAgentPreloaded(tester);
      // Expect
      expect(find.byType(Fleet), findsOneWidget);
    });
  });
}
