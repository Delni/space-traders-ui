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
    final String tradeSymbol;
    final TransactionType type;
    final int units;
    final int pricePerUnit;
    final int totalPrice;
    final DateTime timestamp;

    Transaction({
        required this.waypointSymbol,
        required this.shipSymbol,
        required this.tradeSymbol,
        required this.type,
        required this.units,
        required this.pricePerUnit,
        required this.totalPrice,
        required this.timestamp,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        waypointSymbol: json["waypointSymbol"],
        shipSymbol: json["shipSymbol"],
        tradeSymbol: json["tradeSymbol"],
        type: TransactionTypeMatcher.fromString(json["type"]),
        units: json["units"],
        pricePerUnit: json["pricePerUnit"],
        totalPrice: json["totalPrice"],
        timestamp: DateTime.parse(json["timestamp"]),
    );

    Map<String, dynamic> toJson() => {
        "waypointSymbol": waypointSymbol,
        "shipSymbol": shipSymbol,
        "tradeSymbol": tradeSymbol,
        "type": type.label,
        "units": units,
        "pricePerUnit": pricePerUnit,
        "totalPrice": totalPrice,
        "timestamp": timestamp.toIso8601String(),
    };
}