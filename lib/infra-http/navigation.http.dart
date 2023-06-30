import 'package:space_traders/domain/market/market.dart';
import 'package:space_traders/domain/navigation.dart';
import 'package:space_traders/infra-http/http_client.dart';

class NavigationHttpAdapter implements NavigationRepository {
  @override
  Future<System> getSystem(String systemSymbol) => httpClient
      .get("/systems/$systemSymbol")
      .then((value) => System.fromJson(value.data['data']));

  @override
  Future<List<Map<String, dynamic>>> getRawWaypoints(String systemSymbol) =>
      httpClient
          .get("/systems/$systemSymbol/waypoints")
          .then((value) => List.from(value.data['data']));

  @override
  Future<Market?> findMarket(String waypointSymbol) => httpClient
      .get(
        "/systems/${waypointSymbol.split('-').take(2).join('-')}/waypoints/$waypointSymbol/market",
      )
      .then((value) => Market.fromJson(value.data['data']))
      .catchError(print);
}
