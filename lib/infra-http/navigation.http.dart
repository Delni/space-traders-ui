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
}
