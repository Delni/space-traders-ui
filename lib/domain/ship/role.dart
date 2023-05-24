enum ShipRole {
  fabricator,
  harvester,
  hauler,
  interceptor,
  excavator,
  transport,
  repair,
  surveyor,
  command,
  carrier,
  patrol,
  satellite,
  explorer,
  refinery,
}

extension ShipRoleMapper on ShipRole {
  String get label {
    switch (this) {
      case ShipRole.fabricator:
        return "FABRICATOR";
      case ShipRole.harvester:
        return "HARVESTER";
      case ShipRole.hauler:
        return "HAULER";
      case ShipRole.interceptor:
        return "INTERCEPTOR";
      case ShipRole.excavator:
        return "EXCAVATOR";
      case ShipRole.transport:
        return "TRANSPORT";
      case ShipRole.repair:
        return "REPAIR";
      case ShipRole.surveyor:
        return "SURVEYOR";
      case ShipRole.command:
        return "COMMAND";
      case ShipRole.carrier:
        return "CARRIER";
      case ShipRole.patrol:
        return "PATROL";
      case ShipRole.satellite:
        return "SATELLITE";
      case ShipRole.explorer:
        return "EXPLORER";
      case ShipRole.refinery:
        return "REFINERY";
    }
  }

  static ShipRole fromString(String name) =>
      ShipRole.values.firstWhere((element) => element.label == name.toUpperCase());
}
