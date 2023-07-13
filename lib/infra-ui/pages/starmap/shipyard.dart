import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/market.dart';
import 'package:space_traders/infra-ui/components/bottom_sheet_wrapper.dart';
import 'package:space_traders/infra-ui/components/future_button.dart';
import 'package:space_traders/infra-ui/components/mixins/route_args.mixin.dart';
import 'package:space_traders/infra-ui/components/pallette.dart';
import 'package:space_traders/infra-ui/components/section_header.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';
import 'package:space_traders/infra-ui/providers/fleet.provider.dart';
import 'package:space_traders/infra-ui/providers/starmap.provider.dart';

class ShipyardPage extends StatelessWidget with RouteArgsMixin<String> {
  static const route = "/shipyard";
  const ShipyardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final waypointSymbol = parseRoute(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Shipyard")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: Provider.of<StarMapProvider>(context)
              .findShipyard(waypointSymbol),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const LinearProgressIndicator();
            }
            final ships = snapshot.data!.toList();
            return ListView.builder(
              itemCount: ships.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () => showPurchaseBottomSheet(
                  context,
                  ships[index],
                  waypointSymbol,
                ),
                title: Text(ships[index].name),
                subtitle: Text(ships[index].frame.description),
                trailing: ElevatedButton(
                  onPressed: () => showPurchaseBottomSheet(
                    context,
                    ships[index],
                    waypointSymbol,
                  ),
                  child: const Text("Purchase"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void showPurchaseBottomSheet(
  BuildContext context,
  PurchasableShip ship,
  String waypoint,
) =>
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetWrapper(
          child: Consumer<AgentProvider>(builder: (context, provider, child) {
            var balance = provider.agent.credits - ship.purchasePrice;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SectionHeader(title: ship.name),
                Text(
                  ship.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Your balance"),
                    Text(
                      "${provider.agent.credits}c",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: green),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Price"),
                    Text("-${ship.purchasePrice}c"),
                  ],
                ),
                const Divider(color: Colors.white),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Remaining balance"),
                    Text(
                      "${balance}c",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: balance.isNegative ? red : green),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                ButtonBar(
                  children: [
                    FutureButton(
                      onPressed: balance.isNegative
                          ? null
                          : () =>
                              Provider.of<FleetProvider>(context, listen: false)
                                  .purchaseShip(ship, waypoint)
                                  .then(provider.updateCredits)
                                  .then(Navigator.of(context).pop),
                      child: const Text("Purchase"),
                    )
                  ],
                )
              ],
            );
          }),
        );
      },
    );
