import 'package:space_traders/domain/agent.dart';
import 'package:space_traders/domain/navigation.dart';
import 'package:space_traders/domain/server_status.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-http/agent.http.dart';
import 'package:space_traders/infra-http/http_client.dart';
import 'package:space_traders/infra-http/navigation.http.dart';
import 'package:space_traders/infra-http/server.http.dart';
import 'package:space_traders/infra-http/ship.http.dart';

class Adapters {
  static final Adapters _instance = Adapters._();

  Adapters._();
  factory Adapters() {
    return _instance;
  }

  static AgentRepository agentAdapter = const AgentHttpAdapter();
  static const ShipRepository shipAdapter = ShipHttpAdapter();
  static ServerRepository serverAdapter = ServerHttpAdapter();
  static NavigationRepository navigationAdapter = NavigationHttpAdapter();
  static void Function(String) saveTokenAdapter = saveToken;
}
