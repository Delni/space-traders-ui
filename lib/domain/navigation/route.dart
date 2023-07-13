import 'navpoint.dart';

class NavRoute {
    final NavPoint departure;
    final NavPoint destination;
    final DateTime arrival;
    final DateTime departureTime;

  NavRoute({
        required this.departure,
        required this.destination,
        required this.arrival,
        required this.departureTime,
    });

  factory NavRoute.fromJson(Map<String, dynamic> json) => NavRoute(
        departure: NavPoint.fromJson(json["departure"]),
        destination: NavPoint.fromJson(json["destination"]),
        arrival: DateTime.parse(json["arrival"]),
        departureTime: DateTime.parse(json["departureTime"]),
    );

    Map<String, dynamic> toJson() => {
        "departure": departure.toJson(),
        "destination": destination.toJson(),
        "arrival": arrival.toIso8601String(),
        "departureTime": departureTime.toIso8601String(),
    };
}