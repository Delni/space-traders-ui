import 'waypoint.dart';

class System {
  final String symbol;
  final String sectorSymbol;
  final String type;
  final int x;
  final int y;
  final List<Waypoint> waypoints;
  // final List<Faction> factions;

  System({
    required this.symbol,
    required this.sectorSymbol,
    required this.type,
    required this.x,
    required this.y,
    required this.waypoints,
    // required this.factions,
  });

  Iterable<Waypoint> get allWaypoints => waypoints.expand((element) => [
        element,
        ...element.orbitals,
      ]);

  System copyWith({
    String? symbol,
    String? sectorSymbol,
    String? type,
    int? x,
    int? y,
    List<Waypoint>? waypoints,
  }) =>
      System(
        symbol: symbol ?? this.symbol,
        sectorSymbol: sectorSymbol ?? this.sectorSymbol,
        type: type ?? this.type,
        x: x ?? this.x,
        y: y ?? this.y,
        waypoints: waypoints ?? this.waypoints,
      );

  factory System.fromJson(Map<String, dynamic> json) => System(
      symbol: json["symbol"],
      sectorSymbol: json["sectorSymbol"],
      type: json["type"],
      x: json["x"],
      y: json["y"],
      waypoints: List<Waypoint>.from(
        json["waypoints"].map((x) => Waypoint.fromJson(x)),
      )
      // factions: List<dynamic>.from(json["factions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "sectorSymbol": sectorSymbol,
        "type": type,
        "x": x,
        "y": y,
        "waypoints": List<dynamic>.from(waypoints.map((x) => x.toJson())),
        // "factions": List<Faction>.from(factions.map((x) => x)),
      };
}
