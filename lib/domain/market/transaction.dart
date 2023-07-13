enum TransactionType {
  sell,
  purchase
}

extension TransactionTypeMatcher on TransactionType {
  String get label {
    switch (this) {
      case TransactionType.sell:
        return 'SELL';
      case TransactionType.purchase:
        return 'PURCHASE';
    }
  }

  static TransactionType fromString(String name) => TransactionType.values
      .firstWhere((element) => element.label == name.toUpperCase());
}


class Transaction {
    final String waypointSymbol;
    final String shipSymbol;
  final DateTime timestamp;

  Transaction({
    required this.waypointSymbol,
    required this.shipSymbol,
    required this.timestamp,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        waypointSymbol: json["waypointSymbol"],
        shipSymbol: json["shipSymbol"],
        timestamp: DateTime.parse(json["timestamp"]),
      );
}

class ShipTransaction extends Transaction {
  final int price;
  ShipTransaction({
    required super.waypointSymbol,
    required super.shipSymbol,
    required this.price,
    required super.timestamp,
  });

  factory ShipTransaction.fromJson(Map<String, dynamic> json) =>
      ShipTransaction(
        waypointSymbol: json["waypointSymbol"],
        shipSymbol: json["shipSymbol"],
        price: json["price"],
        timestamp: DateTime.parse(json["timestamp"]),
      );
}

class GoodTransaction extends Transaction {
  final String tradeSymbol;
  final TransactionType type;
  final int units;
  final int pricePerUnit;
  final int totalPrice;

  GoodTransaction({
    required super.waypointSymbol,
    required super.shipSymbol,
    required this.tradeSymbol,
    required this.type,
    required this.units,
    required this.pricePerUnit,
    required this.totalPrice,
    required super.timestamp,
  });

  factory GoodTransaction.fromJson(Map<String, dynamic> json) =>
      GoodTransaction(
        waypointSymbol: json["waypointSymbol"],
        shipSymbol: json["shipSymbol"],
        tradeSymbol: json["tradeSymbol"],
        type: TransactionTypeMatcher.fromString(json["type"]),
        units: json["units"],
        pricePerUnit: json["pricePerUnit"],
        totalPrice: json["totalPrice"],
        timestamp: DateTime.parse(json["timestamp"]),
      );
}
