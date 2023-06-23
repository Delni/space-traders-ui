import 'waypoint.dart';

class NavPoint {
  final String symbol;
  final WaypointType type;
  final String systemSymbol;
  final int x;
  final int y;

  NavPoint({
    required this.symbol,
    required this.type,
    required this.systemSymbol,
    required this.x,
    required this.y,
  });

  factory NavPoint.fromJson(Map<String, dynamic> json) => NavPoint(
        symbol: json["symbol"],
        type: WaypointTypeMatcher.fromString(json["type"]),
        systemSymbol: json["systemSymbol"],
        x: json["x"],
        y: json["y"],
      );

  factory NavPoint.fromWaypoint(Waypoint waypoint) =>
      NavPoint.fromJson(waypoint.toJson());

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "type": type.label,
        "systemSymbol": systemSymbol,
        "x": x,
        "y": y,
      };
}
