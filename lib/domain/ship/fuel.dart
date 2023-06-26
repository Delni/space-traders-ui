class Fuel {
  final int current;
  final int capacity;
  final Consumed consumed;

  Fuel({
    required this.current,
    required this.capacity,
    required this.consumed,
  });

  factory Fuel.fromJson(Map<String, dynamic> json) => Fuel(
        current: json["current"],
        capacity: json["capacity"],
        consumed: Consumed.fromJson(json["consumed"]),
      );

  Map<String, dynamic> toJson() => {
        "current": current,
        "capacity": capacity,
        "consumed": consumed.toJson(),
      };
}

class Consumed {
  final int amount;
  final DateTime timestamp;

  Consumed({
    required this.amount,
    required this.timestamp,
  });

  factory Consumed.fromJson(Map<String, dynamic> json) => Consumed(
        amount: json["amount"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "timestamp": timestamp.toIso8601String(),
      };
}
