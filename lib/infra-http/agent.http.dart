import 'package:space_traders/domain/agent.dart';

import 'http_client.dart';

class AgentHttpAdapter extends AgentRepository {
  const AgentHttpAdapter();

  @override
  Future<Agent> getMe() {
    return httpClient.get("/my/agent").then((value) {
      final Agent agent = Agent.fromJson(value.data["data"]);
      return agent;
    });
  }
}
