import 'dart:math';

import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/components/ship_icon.dart';

import './ship.dart';

class ShipSummary extends StatelessWidget {
  final Ship ship;

  const ShipSummary({super.key, required this.ship});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ShipIcon(
          ship: ship,
          angle: pi / 4,
          opacity: 0.5,
        ),
        title: Hero(tag: ValueKey(ship.symbol), child: Text(ship.symbol)),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: navRow,
        ),
        // trailing: Text(ship.frame.symbol.name),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearProgressIndicator(
                value: durationSinceDepartureTo(DateTime.now().toUtc()) /
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
