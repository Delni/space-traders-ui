import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/navigation.dart';
import 'package:space_traders/infra-ui/components/ship_icon.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';
import 'package:space_traders/infra-ui/providers/fleet.provider.dart';

class WaypointTileHeader extends StatelessWidget {
  final Waypoint waypoint;

  const WaypointTileHeader({super.key, required this.waypoint});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(waypoint.type.asDTO),
                  ),
                  Expanded(child: Text(waypoint.name)),
                ],
              ),
              Consumer2<AgentProvider, FleetProvider>(
                  builder: (context, agentProvider, fleetProvider, _) {
                final waypointShips = fleetProvider.fleet
                    .where((ship) => !ship.inTransit)
                    .where(
                        (ship) => ship.nav.waypointSymbol == waypoint.symbol);
                final waypointContracts = agentProvider.contracts.where(
                    (contract) => contract.terms.deliver.any((element) =>
                        element.destinationSymbol == waypoint.symbol));
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (waypoint.hasMarketplace)
                      const Icon(Icons.add_business),
                    if (waypoint.hasShipyard)
                      const Icon(Icons.construction),
                    const VerticalDivider(),
                    ...waypointShips.map(
                      (ship) => SizedBox(
                        height: 24,
                        width: 24,
                        child: ShipIcon(
                          ship: ship,
                          angle: pi / 2,
                        ),
                      ),
                    ),
                    const VerticalDivider(),
                    ...waypointContracts
                        .map((e) => const Icon(Icons.document_scanner_rounded))
                  ],
                );
              })
            ],
          ),
        ),
        ElevatedButton(
          child: const Text('Navigate'),
          onPressed: () => Navigator.of(context).pop(
            NavPoint.fromWaypoint(waypoint),
          ),
        ),
      ],
    );
  }
}
