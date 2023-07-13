import 'package:space_traders/domain/agent.dart';
import 'package:space_traders/domain/contract/contract.dart';

class AgentInMemoryAdapter implements AgentRepository {
  @override
  Future<Agent> getMe() => Future.value(Agent(
        accountId: "accountId",
        credits: 0,
        headquarters: "HQ",
        symbol: "Starlord",
      ));

  @override
  Future<Contract> accept(Contract contract) {
    throw UnimplementedError();
  }

  @override
  Future<Iterable<Contract>> getMyContracts() {
    throw UnimplementedError();
  }
}
