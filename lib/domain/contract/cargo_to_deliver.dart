class CargoToDeliver {
  final String tradeSymbol;
  final String destinationSymbol;
  final int unitsRequired;
  final int unitsFulfilled;

  CargoToDeliver({
    required this.tradeSymbol,
    required this.destinationSymbol,
    required this.unitsRequired,
    required this.unitsFulfilled,
  });

  factory CargoToDeliver.fromJson(Map<String, dynamic> json) => CargoToDeliver(
        tradeSymbol: json["tradeSymbol"],
        destinationSymbol: json["destinationSymbol"],
        unitsRequired: json["unitsRequired"],
        unitsFulfilled: json["unitsFulfilled"],
      );

  Map<String, dynamic> toJson() => {
        "tradeSymbol": tradeSymbol,
        "destinationSymbol": destinationSymbol,
        "unitsRequired": unitsRequired,
        "unitsFulfilled": unitsFulfilled,
      };
}
