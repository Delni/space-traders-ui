import 'package:space_traders/domain/agent.dart';
import 'package:space_traders/domain/server_status.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-http/agent.http.dart';
import 'package:space_traders/infra-http/server.http.dart';
import 'package:space_traders/infra-http/ship.http.dart';

class Adapters {
  static final Adapters _instance = Adapters._();

  Adapters._();
  factory Adapters() {
    return _instance;
  }

  static const AgentRepository agentAdapter = AgentHttpAdapter();
  static const ShipRepository shipAdapter = ShipHttpAdapter();
  static ServerRepository serverAdapter = ServerHttpAdapter();
}
