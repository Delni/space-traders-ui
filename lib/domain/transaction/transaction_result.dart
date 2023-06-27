import 'package:space_traders/domain/transaction.dart';
import 'package:space_traders/domain/agent.dart';
import 'package:space_traders/domain/ship.dart';

class TransactionResult extends WithCargo {
  final Agent agent;
  final Transaction transaction;

  TransactionResult({
    required this.agent,
    required this.transaction,
    required super.cargo,
  });

  factory TransactionResult.fromJson(Map<String, dynamic> json) =>
      TransactionResult(
        agent: Agent.fromJson(json["agent"]),
        cargo: Cargo.fromJson(json["cargo"]),
        transaction: Transaction.fromJson(json["transaction"]),
      );

  Map<String, dynamic> toJson() => {
        "agent": agent.toJson(),
        "cargo": cargo.toJson(),
        "transaction": transaction.toJson(),
      };
}
