import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/navigation/waypoint_trait.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/components/ship_icon.dart';
import 'package:space_traders/infra-ui/pages/ship/components/ship_actions_bar.dart';
import 'package:space_traders/infra-ui/pages/ship/components/ship_cargo_item.dart';
import 'package:space_traders/infra-ui/pages/ship/components/ship_description.dart';
import 'package:space_traders/infra-ui/pages/ship/components/ship_gauge_info.dart';
import 'package:space_traders/infra-ui/pages/starmap/bottom_system_navigation_map.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';
import 'package:space_traders/infra-ui/providers/fleet.provider.dart';
import 'package:space_traders/infra-ui/providers/starmap.provider.dart';
import 'package:space_traders/infra-ui/components/mixins/route_args.mixin.dart';

import 'components/ship_status.dart';

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
        appBar: AppBar(title: Text(ship.symbol)),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: -MediaQuery.of(context).size.height / 2,
              child: ShipIcon(ship: ship, opacity: 0.1, expand: true),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  ShipDescription(ship: ship),
                  ShipStatusSummary(ship: ship),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
                    child: Text(
                      "Cargo",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  ...ship.cargo.inventory.map((item) => ShipCargoItem(
                      ship: ship, item: item, canSell: hasMarketNearby))
                ],
              ),
            ),
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
