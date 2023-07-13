import 'dart:math';

import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/components/ship_icon.dart';
import 'package:space_traders/infra-ui/pages/ship/components/ship_transit_row.dart';

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
        subtitle: navRow,
        // trailing: Text(ship.frame.symbol.name),
        onTap: () => Navigator.of(context).pushNamed(
          ShipPage.route,
          arguments: ShipPageArguments(ship: ship),
        ),
      ),
    );
  }

  Widget get navRow {
    return switch (ship.nav.status) {
      ShipStatus.docked =>
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(ship.nav.waypointSymbol),
          const Text('DOCKED'),
        ]),
      ShipStatus.inTransit => ShipTransitRow(route: ship.nav.route),
      ShipStatus.inOrbit =>
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(ship.nav.waypointSymbol),
          const Text('IN ORBIT'),
        ]),
    };
  }
}
