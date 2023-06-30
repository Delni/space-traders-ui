import 'trade_good.dart';
import 'transaction.dart';

class Market {
  final String symbol;
  // final List<dynamic> imports;
  // final List<dynamic> exports;
  // final List<Exchange> exchange;
  final List<Transaction> transactions;
  final List<TradeGood> tradeGoods;

  Market({
    required this.symbol,
    // required this.imports,
    // required this.exports,
    // required this.exchange,
    required this.transactions,
    required this.tradeGoods,
  });

  factory Market.fromJson(Map<String, dynamic> json) => Market(
        symbol: json["symbol"],
        // imports: List<dynamic>.from(json["imports"].map((x) => x)),
        // exports: List<dynamic>.from(json["exports"].map((x) => x)),
        // exchange: List<Exchange>.from(json["exchange"].map((x) => Exchange.fromJson(x))),
        transactions: List<Transaction>.from(
          json["transactions"].map((x) => Transaction.fromJson(x)),
        ),
        tradeGoods: List<TradeGood>.from(
          json["tradeGoods"].map((x) => TradeGood.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        // "imports": List<dynamic>.from(imports.map((x) => x)),
        // "exports": List<dynamic>.from(exports.map((x) => x)),
        // "exchange": List<dynamic>.from(exchange.map((x) => x.toJson())),
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
        "tradeGoods": List<dynamic>.from(tradeGoods.map((x) => x.toJson())),
      };
}
