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
  String get asDTO => switch (this) {
        WaypointType.planet => 'PLANET',
        WaypointType.gasGiant => 'GAS_GIANT',
        WaypointType.moon => 'MOON',
        WaypointType.orbitalStation => 'ORBITAL_STATION',
        WaypointType.jumpGate => 'JUMP_GATE',
        WaypointType.asteroidField => 'ASTEROID_FIELD',
        WaypointType.nebula => 'NEBULA',
        WaypointType.debrisField => 'DEBRIS_FIELD',
        WaypointType.gravityWell => 'GRAVITY_WELL'
      };

  String get label => switch (this) {
        WaypointType.planet => 'Planet',
        WaypointType.gasGiant => 'Gas Giant',
        WaypointType.moon => 'Moon',
        WaypointType.orbitalStation => 'Orbital station',
        WaypointType.jumpGate => 'Jump gate',
        WaypointType.asteroidField => 'Asteroid field',
        WaypointType.nebula => 'Nebula',
        WaypointType.debrisField => 'Debris field',
        WaypointType.gravityWell => 'Gravity well'
      };

  static WaypointType fromString(String name) => WaypointType.values
      .firstWhere((element) => element.asDTO == name.toUpperCase());
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

  String get systemSymbol => symbol.split('-').take(2).join('-');
  String get name => symbol.split('-').last;

  bool get hasMarketplace => traits.any(
        (e) => e.symbol == WaypointTraitSymbol.MARKETPLACE,
      );
  bool get isExtractable => {WaypointType.asteroidField}.contains(type);

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
        "type": type.asDTO,
        "x": position.dx.toInt(),
        "y": position.dy.toInt(),
      };
}
