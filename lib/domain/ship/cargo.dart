import 'cargo_item.dart';

class Cargo {
    final int capacity;
    final int units;
    final List<CargoItem> inventory;

    Cargo({
        required this.capacity,
        required this.units,
        required this.inventory,
    });

    factory Cargo.fromJson(Map<String, dynamic> json) => Cargo(
        capacity: json["capacity"],
        units: json["units"],
        inventory: List<CargoItem>.from(json["inventory"].map((x) => CargoItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "capacity": capacity,
        "units": units,
        "inventory": List<dynamic>.from(inventory.map((x) => x.toJson())),
    };
}