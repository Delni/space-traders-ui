import 'package:space_traders/domain/transaction.dart';
import 'package:space_traders/domain/agent.dart';
import 'package:space_traders/domain/ship.dart';

class TransactionResult {
    final Agent agent;
    final Cargo cargo;
    final Transaction transaction;

    TransactionResult({
        required this.agent,
        required this.cargo,
        required this.transaction,
    });

    factory TransactionResult.fromJson(Map<String, dynamic> json) => TransactionResult(
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