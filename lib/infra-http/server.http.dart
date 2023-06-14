import 'package:dio/dio.dart';
import 'package:space_traders/domain/faction.dart';
import 'package:space_traders/domain/server_status.dart';

class ServerHttpAdapter implements ServerRepository {
  ServerHttpAdapter();
  final Dio _client = Dio();

  @override
  Future<ServerStatus> getStatus() => _client
      .get('https://api.spacetraders.io/v2')
      .then((value) => value.data)
      .then((value) => ServerStatus(
            nextReset: DateTime.parse(value["serverResets"]["next"] as String),
            annoucements:
                List<Map<String, dynamic>>.from(value["announcements"])
                    .map(Annoucement.fromJson),
          ));

  @override
  Future<String> register(String agentName, Faction faction) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
