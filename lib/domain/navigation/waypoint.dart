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

  static WaypointType fromString(String name) =>
      WaypointType.values.firstWhere((element) => element.label == name.toUpperCase());
}