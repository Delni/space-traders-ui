import '../market.dart';
import 'system.dart';

abstract class NavigationRepository {
  const NavigationRepository();

  Future<System> getSystem(String systemSymbol);

  Future<Iterable<Map<String, dynamic>>> getRawWaypoints(String systemSymbol);

  Future<Market?> findMarket(String waypointSymbol);
  Future<Iterable<PurchasableShip>?> findShipyard(String waypointSymbol);
}
