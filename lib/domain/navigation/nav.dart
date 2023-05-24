import 'package:space_traders/domain/ship/flight_mode.dart';
import 'package:space_traders/domain/ship/ship_status.dart';

import 'route.dart';

class Nav {
    final String systemSymbol;
    final String waypointSymbol;
    final Route route;
    final ShipStatus status;
    final FlightMode flightMode;

    Nav({
        required this.systemSymbol,
        required this.waypointSymbol,
        required this.route,
        required this.status,
        required this.flightMode,
    });

    factory Nav.fromJson(Map<String, dynamic> json) => Nav(
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