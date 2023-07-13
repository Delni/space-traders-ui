import 'package:space_traders/domain/market.dart';
import 'package:space_traders/domain/agent.dart';
import 'package:space_traders/domain/ship.dart';

class ShipTransactionResult {
  final Agent agent;
  final ShipTransaction transaction;
  final Ship ship;

  ShipTransactionResult({
    required this.agent,
    required this.transaction,
    required this.ship,
  });

  factory ShipTransactionResult.fromJson(Map<String, dynamic> json) =>
      ShipTransactionResult(
        agent: Agent.fromJson(json["agent"]),
        ship: Ship.fromJson(json["ship"]),
        transaction: ShipTransaction.fromJson(json["transaction"]),
      );
}
