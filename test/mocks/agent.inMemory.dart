import 'package:space_traders/domain/agent.dart';

class AgentInMemoryAdapter implements AgentRepository {
  @override
  Future<Agent> getMe() => Future.value(Agent(
        accountId: "accountId",
        credits: 0,
        headquarters: "HQ",
        symbol: "symbol",
      ));
}
