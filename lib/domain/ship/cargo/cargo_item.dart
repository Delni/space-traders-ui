class CargoItemSummary {
  final String symbol;
    final int units;

    CargoItemSummary({
        required this.symbol,
        required this.units,
    });

    factory CargoItemSummary.fromJson(Map<String, dynamic> json) => CargoItemSummary(
        symbol: json["symbol"],
        units: json["units"],
    );

    Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "units": units,
    };

    @override
  String toString() => "$units of $symbol";
}

class CargoItem extends CargoItemSummary{
    final String name;
    final String description;

    CargoItem({
        required super.symbol,
        required this.name,
        required this.description,
        required super.units,
    });

    factory CargoItem.fromJson(Map<String, dynamic> json) => CargoItem(
        symbol: json["symbol"],
        name: json["name"],
        description: json["description"],
        units: json["units"],
    );

    @override
      Map<String, dynamic> toJson() => {
        ...super.toJson(),
        "name": name,
        "description": description,
    };
}