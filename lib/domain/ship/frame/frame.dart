// ignore_for_file: constant_identifier_names

import 'engine_requirements.dart';

enum ShipFrames {
  PROBE,
  DRONE,
  INTERCEPTOR,
  RACER,
  FIGHTER,
  FRIGATE,
  SHUTTLE,
  EXPLORER,
  MINER,
  LIGHT_FREIGHTER,
  HEAVY_FREIGHTER,
  TRANSPORT,
  DESTROYER,
  CRUISER,
  CARRIER,
}

class ShipFrame {
  final ShipFrames symbol;
  final String name;
  final String description;
  final int moduleSlots;
  final int mountingPoints;
  final int fuelCapacity;
  final int condition;
  final EngineRequirements requirements;

  ShipFrame({
    required this.symbol,
    required this.name,
    required this.description,
    required this.moduleSlots,
    required this.mountingPoints,
    required this.fuelCapacity,
    required this.condition,
    required this.requirements,
  });

  factory ShipFrame.fromJson(Map<String, dynamic> json) => ShipFrame(
        symbol: ShipFrames.values
            .firstWhere((element) => "FRAME_${element.name}" == json["symbol"]),
        name: json["name"],
        description: json["description"],
        moduleSlots: json["moduleSlots"],
        mountingPoints: json["mountingPoints"],
        fuelCapacity: json["fuelCapacity"],
        condition: json["condition"] ?? 0,
        requirements: EngineRequirements.fromJson(json["requirements"]),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "name": name,
        "description": description,
        "moduleSlots": moduleSlots,
        "mountingPoints": mountingPoints,
        "fuelCapacity": fuelCapacity,
        "condition": condition,
        "requirements": requirements.toJson(),
      };
}
