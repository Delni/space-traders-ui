import 'package:space_traders/domain/faction.dart';

import 'status.dart';

abstract class ServerRepository {
  Future<String> register(String agentName, Faction faction);
  Future<ServerStatus> getStatus();
}
