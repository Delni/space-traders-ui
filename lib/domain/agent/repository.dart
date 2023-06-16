import 'agent.dart';

abstract class AgentRepository {
  const AgentRepository();
  
  Future<Agent> getMe();
}

class AgentSymbolAlreadyClaimed implements Exception {}
