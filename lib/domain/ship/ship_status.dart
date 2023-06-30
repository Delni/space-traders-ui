enum ShipStatus {
  inTransit,
  inOrbit,
  docked,
}

extension ShipStatusMatcher on ShipStatus {
  String get asDTO => switch (this) {
        ShipStatus.inTransit => 'IN_TRANSIT',
        ShipStatus.inOrbit => 'IN_ORBIT',
        ShipStatus.docked => 'DOCKED'
      };

  String get label => switch (this) {
        ShipStatus.inTransit => 'In transit',
        ShipStatus.inOrbit => 'In orbit',
        ShipStatus.docked => 'Docked'
      };

  static ShipStatus fromString(String name) => ShipStatus.values
      .firstWhere((element) => element.asDTO == name.toUpperCase());
}
