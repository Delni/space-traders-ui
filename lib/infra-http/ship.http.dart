import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/domain/transaction/transaction_result.dart';
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
      httpClient.post("/my/ships/${ship.symbol}/extract", data: {
        "waypointSymbol": waypointSymbol
      }).then((value) => ExtractionResult.fromJson(value.data['data']));

  @override
  Future<TransactionResult> sell({
    required Ship ship,
    required CargoItemSummary goods,
  }) =>
      httpClient
          .post("/my/ships/${ship.symbol}/sell", data: goods.toJson())
          .then((value) => TransactionResult.fromJson(value.data['data']));
}
