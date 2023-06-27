import 'package:flutter/material.dart';
import 'package:space_traders/domain/navigation/waypoint_trait.dart';

enum WaypointType {
  planet,
  gasGiant,
  moon,
  orbitalStation,
  jumpGate,
  asteroidField,
  nebula,
  debrisField,
  gravityWell,
}

extension WaypointTypeMatcher on WaypointType {
  String get label {
    switch (this) {
      case WaypointType.planet:
        return 'PLANET';
      case WaypointType.gasGiant:
        return 'GAS_GIANT';
      case WaypointType.moon:
        return 'MOON';
      case WaypointType.orbitalStation:
        return 'ORBITAL_STATION';
      case WaypointType.jumpGate:
        return 'JUMP_GATE';
      case WaypointType.asteroidField:
        return 'ASTEROID_FIELD';
      case WaypointType.nebula:
        return 'NEBULA';
      case WaypointType.debrisField:
        return 'DEBRIS_FIELD';
      case WaypointType.gravityWell:
        return 'GRAVITY_WELL';
    }
  }

  static WaypointType fromString(String name) => WaypointType.values
      .firstWhere((element) => element.label == name.toUpperCase());
}

class Waypoint {
  final String symbol;
  final WaypointType type;
  final Offset position;
  final List<Waypoint> orbitals;
  final List<WaypointTrait> traits;

  Waypoint({
    required this.symbol,
    required this.type,
    required this.position,
    required this.orbitals,
    required this.traits,
  });

  String get name => symbol.split('-').last;

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
      symbol: json["symbol"],
      type: WaypointTypeMatcher.fromString(json["type"]),
      position: Offset(
        (json["x"] as int).toDouble(),
        (json["y"] as int).toDouble(),
      ),
      orbitals: [],
      traits: []);

  Map<String, dynamic> toJson() => {
        "systemSymbol": symbol.split('-').take(2).join('-'),
        "symbol": symbol,
        "type": type.label,
        "x": position.dx.toInt(),
        "y": position.dy.toInt(),
      };
}
