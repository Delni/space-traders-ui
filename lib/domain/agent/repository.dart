import 'package:space_traders/domain/contract.dart';

import 'agent.dart';

abstract class AgentRepository {
  const AgentRepository();

  Future<Agent> getMe();
  Future<Iterable<Contract>> getMyContracts();
  Future<Contract> accept(Contract contract);
}

class AgentSymbolAlreadyClaimed implements Exception {}
