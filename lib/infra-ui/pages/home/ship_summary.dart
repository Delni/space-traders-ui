import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/pages/ship/ship.dart';

class ShipSummary extends StatelessWidget {
  final Ship ship;

  const ShipSummary({super.key, required this.ship});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.rocket_rounded),
        title: Hero(tag: ValueKey(ship.symbol), child: Text(ship.symbol)),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: navRow,
        ),
        onTap: () => Navigator.of(context).pushNamed(
          ShipPage.route,
          arguments: ShipPageArguments(ship: ship),
        ),
      ),
    );
  }

  List<Widget> get navRow {
    return switch (ship.nav.status) {
      ShipStatus.docked => [
          Text(ship.nav.waypointSymbol),
          const Text('DOCKED'),
        ],
      ShipStatus.inTransit => [
          Text(ship.nav.route.departure.symbol),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Expanded(
              child: LinearProgressIndicator(
                value: durationSinceDepartureTo(DateTime.now()) /
                    durationSinceDepartureTo(ship.nav.route.arrival),
              ),
            ),
          ),
          Text(ship.nav.route.destination.symbol),
        ],
      ShipStatus.inOrbit => [
          Text(ship.nav.waypointSymbol),
          const Text('IN ORBIT'),
        ],
    };
  }

  int durationSinceDepartureTo(DateTime time) =>
      time.difference(ship.nav.route.departureTime).inMicroseconds;
}
