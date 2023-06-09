import 'package:dio/dio.dart';
import 'package:space_traders/domain/agent.dart';

import 'http_client.dart';

class AgentHttpAdapter extends AgentRepository {
  const AgentHttpAdapter();

  @override
  Future<Agent> getMe() {
    return httpClient
        .get("/my/agent")
        .then(getDataAs<Map<String, dynamic>>)
        .then(Agent.fromJson)
        .catchError((error) => throw getErrorMessage(error as DioError));
  }
}
