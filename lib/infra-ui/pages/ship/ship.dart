
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/components/future_button.dart';
import 'package:space_traders/infra-ui/components/ship_icon.dart';
import 'package:space_traders/infra-ui/pages/ship/components/ship_actions_bar.dart';
import 'package:space_traders/infra-ui/components/section_header.dart';
import 'package:space_traders/infra-ui/pages/ship/components/ship_cargo_item.dart';
import 'package:space_traders/infra-ui/pages/ship/components/ship_description.dart';
import 'package:space_traders/infra-ui/pages/ship/components/ship_location_amenities.dart';
import 'package:space_traders/infra-ui/pages/starmap/bottom_system_navigation_map.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';
import 'package:space_traders/infra-ui/providers/fleet.provider.dart';
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
                  const SectionHeader(title: 'Cargo'),
                  if (ship.cargo.inventory.isEmpty)
                    Text(
                      "Cargo is empty",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15),
                    ),
                  ...ship.cargo.inventory.map(
                    (item) => ShipCargoItem(
                      ship: ship,
                      item: item,
                    ),
                  ),
                  SectionHeader(
                    title: 'Location',
                    actions: [
                      FutureButton(
                        onPressed: () => provider.orbitOrDock(ship),
                        label: ship.isDocked ? 'Orbit' : 'Dock',
                      )
                    ],
                  ),
                  ShipLocationAmenities(
                    ship: ship,
                    onExtract: () => provider.extract(ship),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ShipActionsBar(
          ship: ship,
          onRefuel: () => provider.refuel(ship).then(
                (value) =>
                    Provider.of<AgentProvider>(context, listen: false).getMe(),
              ),
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
