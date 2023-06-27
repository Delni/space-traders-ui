import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/navigation/waypoint_trait.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/pages/ship/ship_actions_bar.dart';
import 'package:space_traders/infra-ui/pages/ship/ship_cargo_item.dart';
import 'package:space_traders/infra-ui/pages/ship/ship_gauge_info.dart';
import 'package:space_traders/infra-ui/pages/starmap/bottom_system_navigation_map.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';
import 'package:space_traders/infra-ui/providers/fleet.provider.dart';
import 'package:space_traders/infra-ui/providers/starmap.provider.dart';
import 'package:space_traders/infra-ui/route_args.mixin.dart';

class ShipPageArguments {
  final Ship ship;

  ShipPageArguments({required this.ship});
}

class ShipPage extends StatelessWidget with RouteArgs<ShipPageArguments> {
  static const route = "/ships/details";

  const ShipPage({super.key});
  @override
  Widget build(BuildContext context) {
    final shipSymbol = parseRoute(context).ship.symbol;
    return Consumer<FleetProvider>(builder: (context, provider, _) {
      final ship = provider.getBySymbol(shipSymbol);
      final hasMarketNearby =
          Provider.of<StarMapProvider>(context, listen: false)
              .getWaypoint(ship.nav.waypointSymbol)
              .then(
                (value) => value.traits.any(
                  (element) =>
                      element.symbol == WaypointTraitSymbol.MARKETPLACE &&
                      ship.nav.status == ShipStatus.docked,
                ),
              );
      return Scaffold(
        appBar: AppBar(
          title: Hero(tag: ValueKey(ship.symbol), child: Text(ship.symbol)),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Hero(
                tag: ValueKey("${ship.symbol}_icon"),
                child: const Icon(Icons.rocket_launch),
              ),
              title: Text("Type: ${ship.frame.symbol.name}"),
              subtitle: Text(ship.frame.description),
              trailing: Column(children: [
                Text(ship.nav.status.name),
                Text(ship.nav.waypointSymbol),
              ]),
            ),
            ShipGaugeInfo(
              label: "Fuel",
              units: ship.fuel.current,
              capacity: ship.fuel.capacity,
            ),
            ShipGaugeInfo(
              label: "Cargo",
              units: ship.cargo.units,
              capacity: ship.cargo.capacity,
            ),
            ...ship.cargo.inventory.map((item) =>
                ShipCargoItem(ship: ship, item: item, canSell: hasMarketNearby))
          ],
        ),
        bottomNavigationBar: ShipActionsBar(
          ship: ship,
          onDock: () => provider.orbitOrDock(ship),
          onOrbit: () => provider.orbitOrDock(ship),
          onRefuel: () => provider.refuel(ship).then(
                (value) =>
                    Provider.of<AgentProvider>(context, listen: false).getMe(),
              ),
          onExtract: () => provider.extract(ship),
          onNavigate: () => showBottomSystemNavigationMap(
            context,
            ship.nav.systemSymbol,
          ).then((value) {
            if (value != null) {
              provider.navigateTo(value, ship);
            }
          }),
        ),
      );
    });
  }
}
