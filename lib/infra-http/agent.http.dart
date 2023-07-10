import 'package:dio/dio.dart';
import 'package:space_traders/domain/agent.dart';
import 'package:space_traders/domain/contract/contract.dart';

import 'http_client.dart';

class AgentHttpAdapter extends AgentRepository {
  const AgentHttpAdapter();

  @override
  Future<Agent> getMe() => httpClient
        .get("/my/agent")
        .then(getDataAs<Map<String, dynamic>>)
        .then(Agent.fromJson)
        .catchError((error) => throw getErrorMessage(error as DioError));

  @override
  Future<Iterable<Contract>> getMyContracts() => httpClient
      .get("/my/contracts")
      .then(getDataAs<List<dynamic>>)
      .then((value) => value.map((element) => Contract.fromJson(element)))
      .catchError((error) => throw getErrorMessage(error as DioError));

  @override
  Future<Contract> accept(Contract contract) => httpClient
      .post("/my/contracts/${contract.id}/accept")
      .then((value) => value.data['data']['contract'])
      .then((value) => Contract.fromJson(value))
      .catchError((error) => throw getErrorMessage(error as DioError));
}
