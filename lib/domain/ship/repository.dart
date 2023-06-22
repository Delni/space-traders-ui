import 'package:space_traders/domain/navigation.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/domain/transaction/transaction_result.dart';

abstract class ShipRepository {
  const ShipRepository();
  Future<Iterable<Ship>> getMyShips();
  Future<ExtractionResult> extract({
    required Ship ship,
    required String waypointSymbol,
  });
  Future<TransactionResult> sell({
    required Ship ship,
    required CargoItemSummary goods,
  });

  Future<ShipNav> orbitOrDock({
    required Ship ship,
    required String waypointSymbol,
    required ShipStatus to,
  });
}
