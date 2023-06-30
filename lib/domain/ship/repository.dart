import 'package:space_traders/domain/navigation.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/domain/ship/fuel.dart';
import 'package:space_traders/domain/market/transaction_result.dart';

abstract class ShipRepository {
  const ShipRepository();
  Future<Iterable<Ship>> getMyShips();

  Future<Fuel> refuel({
    required Ship ship,
    required String waypointSymbol,
  });
  
  Future<ExtractionResult> extract({
    required Ship ship,
    required String waypointSymbol,
  });

  Future<TransactionResult> sell({
    required Ship ship,
    required CargoItemSummary goods,
  });

  Future<TransactionResult> purchase({
    required Ship ship,
    required CargoItemSummary goods,
  });

  Future<Cargo> jettison({
    required Ship ship,
    required CargoItemSummary goods,
  });

  Future<ShipNav> orbitOrDock({
    required Ship ship,
    required String waypointSymbol,
    required ShipStatus to,
  });

  Future<NavigationResult> navigateTo({
    required Ship ship,
    required String waypointSymbol,
  });
}
