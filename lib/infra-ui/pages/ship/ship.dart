import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/pages/ship/ship_actions_bar.dart';
import 'package:space_traders/infra-ui/pages/ship/ship_cargo_item.dart';
import 'package:space_traders/infra-ui/pages/starmap/bottom_system_navigation_map.dart';
import 'package:space_traders/infra-ui/providers/fleet.provider.dart';
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cargo",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("${ship.cargo.units}/${ship.cargo.capacity}"),
                      SizedBox(
                        width: 50.0,
                        child: LinearProgressIndicator(
                          value:
                              ship.cargo.units / (max(ship.cargo.capacity, 1)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ...ship.cargo.inventory.map((item) => ShipCargoItem(item: item))
          ],
        ),
        bottomNavigationBar: ShipActionsBar(
          ship: ship,
          onDock: () => provider.orbitOrDock(ship),
          onOrbit: () => provider.orbitOrDock(ship),
          onNavigate: () => showBottomSystemNavigationMap(
            context,
            ship.nav.systemSymbol,
          ).then((value) => print(value.toString())),
        ),
      );
    });
  }
}
