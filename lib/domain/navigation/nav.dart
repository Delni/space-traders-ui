import 'package:space_traders/domain/ship/flight_mode.dart';
import 'package:space_traders/domain/ship/ship_status.dart';

import 'route.dart';

class ShipNav {
    final String systemSymbol;
    final String waypointSymbol;
    final Route route;
    final ShipStatus status;
    final FlightMode flightMode;

  ShipNav({
        required this.systemSymbol,
        required this.waypointSymbol,
        required this.route,
        required this.status,
        required this.flightMode,
    });

  factory ShipNav.fromJson(Map<String, dynamic> json) => ShipNav(
        systemSymbol: json["systemSymbol"],
        waypointSymbol: json["waypointSymbol"],
        route: Route.fromJson(json["route"]),
        status: ShipStatusMatcher.fromString(json["status"]),
        flightMode: FlightModeMatcher.fromString(json["flightMode"]),
    );

    Map<String, dynamic> toJson() => {
        "systemSymbol": systemSymbol,
        "waypointSymbol": waypointSymbol,
        "route": route.toJson(),
        "status": status.label,
        "flightMode": flightMode,
    };
}