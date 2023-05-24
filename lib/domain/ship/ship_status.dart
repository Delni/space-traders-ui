enum ShipStatus {
  inTransit,
  inOrbit,
  docked,
}

extension ShipStatusMatcher on ShipStatus {
  String get label {
    switch (this) {
      case ShipStatus.inTransit:
        return 'IN_TRANSIT';
      case ShipStatus.inOrbit:
        return 'IN_ORBIT';
      case ShipStatus.docked:
        return 'DOCKED';
    }
  }

  static ShipStatus fromString(String name) => ShipStatus.values
      .firstWhere((element) => element.label == name.toUpperCase());
}
