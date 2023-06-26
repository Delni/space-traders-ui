class Cooldown {
  final String shipSymbol;
  final int totalSeconds;
  int remainingSeconds;
  final DateTime expiration;

  Cooldown({
    required this.shipSymbol,
    required this.totalSeconds,
    required this.remainingSeconds,
    required this.expiration,
  });

  void decrease() {
    remainingSeconds--;
  }

  factory Cooldown.fromJson(Map<String, dynamic> json) => Cooldown(
        shipSymbol: json["shipSymbol"],
        totalSeconds: json["totalSeconds"],
        remainingSeconds: json["remainingSeconds"],
        expiration: DateTime.parse(json["expiration"]),
      );

  Map<String, dynamic> toJson() => {
        "shipSymbol": shipSymbol,
        "totalSeconds": totalSeconds,
        "remainingSeconds": remainingSeconds,
        "expiration": expiration.toIso8601String(),
      };

  Cooldown copyWith({
    String? shipSymbol,
    int? totalSeconds,
    int? remainingSeconds,
    DateTime? expiration,
  }) =>
      Cooldown(
        shipSymbol: shipSymbol ?? this.shipSymbol,
        totalSeconds: totalSeconds ?? this.totalSeconds,
        remainingSeconds: remainingSeconds ?? this.remainingSeconds,
        expiration: expiration ?? this.expiration,
      );
}
