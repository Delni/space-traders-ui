import 'package:space_traders/domain/navigation.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/domain/ship/fuel.dart';
import 'package:space_traders/domain/market.dart';
import 'package:space_traders/infra-http/http_client.dart';

class ShipHttpAdapter extends ShipRepository {
  const ShipHttpAdapter();

  @override
  Future<Iterable<Ship>> getMyShips() =>
      httpClient.get("/my/ships").then((value) =>
          (value.data["data"] as List).map((value) => Ship.fromJson(value)));

  @override
  Future<ExtractionResult> extract({
    required Ship ship,
    required String waypointSymbol,
  }) =>
      httpClient
          .post("/my/ships/${ship.symbol}/extract",
              data: {"waypointSymbol": waypointSymbol})
          .then((value) => ExtractionResult.fromJson(value.data['data']))
          .catchError(
            (error) => ExtractionResult(
                cargo: ship.cargo,
                extraction: Extraction(
                  shipSymbol: ship.symbol,
                  yield: CargoItemSummary(symbol: '', units: 0),
                ),
              cooldown: error.response?.data['error']['code'] == 4000
                  ? Cooldown.fromJson(
                  error.response?.data['error']['data']['cooldown'],
                    )
                  : Cooldown.zero.copyWith(shipSymbol: ship.symbol),
            ),
          );

  @override
  Future<TransactionResult> sell({
    required Ship ship,
    required CargoItemSummary goods,
  }) =>
      httpClient
          .post("/my/ships/${ship.symbol}/sell", data: goods.toJson())
          .then((value) => TransactionResult.fromJson(value.data['data']));

  @override
  Future<TransactionResult> purchase({
    required Ship ship,
    required CargoItemSummary goods,
  }) =>
      httpClient
          .post("/my/ships/${ship.symbol}/purchase", data: goods.toJson())
          .then((value) => TransactionResult.fromJson(value.data['data']));

  @override
  Future<Cargo> jettison({
    required Ship ship,
    required CargoItemSummary goods,
  }) =>
      httpClient
          .post("/my/ships/${ship.symbol}/jettison", data: goods.toJson())
          .then((value) => Cargo.fromJson(value.data['data']['cargo']));

  @override
  Future<ShipNav> orbitOrDock({
    required Ship ship,
    required String waypointSymbol,
    required ShipStatus to,
  }) =>
      httpClient.post(
        "/my/ships/${ship.symbol}/${to == ShipStatus.docked ? 'dock' : 'orbit'}",
        data: {"waypointSymbol": waypointSymbol},
      ).then((value) => ShipNav.fromJson(value.data['data']['nav']));

  @override
  Future<NavigationResult> navigateTo({
    required Ship ship,
    required String waypointSymbol,
  }) =>
      httpClient.post(
        "/my/ships/${ship.symbol}/navigate",
        data: {"waypointSymbol": waypointSymbol},
      ).then((value) => NavigationResult.fromJson(value.data['data']));

  @override
  Future<Fuel> refuel({required Ship ship, required String waypointSymbol}) =>
      httpClient.post(
        "/my/ships/${ship.symbol}/refuel",
        data: {"waypointSymbol": waypointSymbol},
      ).then((value) => Fuel.fromJson(value.data['data']['fuel']));
      
  @override
  Future<ShipTransactionResult> purchaseShip(
          {required PurchasableShip ship, required String waypointSymbol}) =>
      httpClient.post(
        "/my/ships",
        data: {
          "waypointSymbol": waypointSymbol,
          "shipType": ship.type.name,
        },
      ).then((value) => ShipTransactionResult.fromJson(value.data['data']));
      
}
