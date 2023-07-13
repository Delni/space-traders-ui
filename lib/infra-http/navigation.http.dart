import 'package:space_traders/domain/market.dart';
import 'package:space_traders/domain/navigation.dart';
import 'package:space_traders/infra-http/http_client.dart';

class NavigationHttpAdapter implements NavigationRepository {
  @override
  Future<System> getSystem(String systemSymbol) => httpClient
      .get("/systems/$systemSymbol")
      .then((value) => System.fromJson(value.data['data']));

  @override
  Future<Iterable<Map<String, dynamic>>> getRawWaypoints(String systemSymbol) =>
      httpClient
          .get("/systems/$systemSymbol/waypoints")
          .then((value) => List.from(value.data['data']));

  @override
  Future<Market?> findMarket(String waypointSymbol) => httpClient
      .get(
        "/systems/${waypointSymbol.split('-').take(2).join('-')}/waypoints/$waypointSymbol/market",
      )
      .then((value) => Market.fromJson(value.data['data']));

  @override
  Future<Iterable<PurchasableShip>?> findShipyard(String waypointSymbol) =>
      httpClient
          .get(
            "/systems/${waypointSymbol.split('-').take(2).join('-')}/waypoints/$waypointSymbol/shipyard",
          )
          .then((value) => List.from(value.data['data']['ships']))
          .then((value) => value.map((json) => PurchasableShip.fromJson(json)));
}
