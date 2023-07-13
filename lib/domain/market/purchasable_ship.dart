// ignore_for_file: constant_identifier_names

import 'package:space_traders/domain/ship.dart';

enum ShipType {
  SHIP_PROBE,
  SHIP_MINING_DRONE,
  SHIP_INTERCEPTOR,
  SHIP_LIGHT_HAULER,
  SHIP_COMMAND_FRIGATE,
  SHIP_EXPLORER,
  SHIP_HEAVY_FREIGHTER,
  SHIP_LIGHT_SHUTTLE,
  SHIP_ORE_HOUND,
  SHIP_REFINING_FREIGHTER
}

class PurchasableShip {
  final ShipType type;
  final String name;
  final String description;
  final int purchasePrice;
  final ShipFrame frame;
  // final Reactor reactor;
  // final Engine engine;
  // final List<Module> modules;
  // final List<Mount> mounts;

  PurchasableShip({
    required this.type,
    required this.name,
    required this.description,
    required this.purchasePrice,
    required this.frame,
    // required this.reactor,
    // required this.engine,
    // required this.modules,
    // required this.mounts,
  });

  factory PurchasableShip.fromJson(Map<String, dynamic> json) =>
      PurchasableShip(
        type: ShipType.values
            .firstWhere((element) => element.name == json["type"]),
        name: json["name"],
        description: json["description"],
        purchasePrice: json["purchasePrice"],
        frame: ShipFrame.fromJson(json["frame"]),
        // reactor: Reactor.fromJson(json["reactor"]),
        // engine: Engine.fromJson(json["engine"]),
        // modules: List<dynamic>.from(json["modules"].map((x) => x)),
        // mounts: List<dynamic>.from(json["mounts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type.name,
        "name": name,
        "description": description,
        "purchasePrice": purchasePrice,
        "frame": frame.toJson(),
        // "reactor": reactor.toJson(),
        // "engine": engine.toJson(),
        // "modules": List<dynamic>.from(modules.map((x) => x)),
        // "mounts": List<dynamic>.from(mounts.map((x) => x)),
      };
}
