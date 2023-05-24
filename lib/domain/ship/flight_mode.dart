enum FlightMode {
  drift,
  stealth,
  cruise,
  burn,
}

extension FlightModeMatcher on FlightMode {
  String get label {
    switch (this) {
      
      case FlightMode.drift:
        return 'DRIFT';
      case FlightMode.stealth:
        return 'STEALTH';
      case FlightMode.cruise:
        return 'CRUISE';
      case FlightMode.burn:
        return 'BURN';
    }
  }

  static FlightMode fromString(String name) => FlightMode.values
      .firstWhere((element) => element.label == name.toUpperCase());
}
