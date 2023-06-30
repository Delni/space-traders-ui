import '../market.dart';
import 'system.dart';

abstract class NavigationRepository {
  const NavigationRepository();

  Future<System> getSystem(String systemSymbol);

  Future<List<Map<String, dynamic>>> getRawWaypoints(String systemSymbol);

  Future<Market?> findMarket(String waypointSymbol);
}
