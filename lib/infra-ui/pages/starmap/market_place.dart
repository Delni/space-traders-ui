import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/market.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/components/mixins/route_args.mixin.dart';
import 'package:space_traders/infra-ui/components/pallette.dart';
import 'package:space_traders/infra-ui/components/section_header.dart';
import 'package:space_traders/infra-ui/components/space_traders_icons_icons.dart';
import 'package:space_traders/infra-ui/pages/ship/components/ship_cargo_item.dart';
import 'package:space_traders/infra-ui/pages/starmap/refuel_button.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';
import 'package:space_traders/infra-ui/providers/fleet.provider.dart';
import 'package:space_traders/infra-ui/providers/starmap.provider.dart';

import '../../components/good_exchange_sheet.dart';

class MarketPlacePage extends StatelessWidget with RouteArgs<Ship> {
  static const route = "/market";
  const MarketPlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ship = parseRoute(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Marketplace")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: Provider.of<StarMapProvider>(context)
              .findMarket(ship.nav.waypointSymbol),
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SectionHeader(title: "Cargo"),
                Expanded(
                  child:
                      Consumer<FleetProvider>(builder: (context, provider, _) {
                    final cargo = provider.getBySymbol(ship.symbol).cargo;
                    if (ship.cargo.inventory.isEmpty) {
                      return Text(
                        "Cargo is empty",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 15),
                      );
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) => ShipCargoItem(
                        ship: ship,
                        item: cargo.inventory[index],
                        action: ElevatedButton(
                          child: const Text('Sell'),
                          onPressed: () => showSellingSheet(
                            context,
                            cargo.inventory[index],
                            ship,
                            pricePerUnit: snapshot.data?.tradeGoods
                                .firstWhere((element) =>
                                    element.symbol ==
                                    cargo.inventory[index].symbol)
                                .sellPrice,
                          ),
                        ),
                      ),
                      itemCount: cargo.inventory.length,
                    );
                  }),
                ),
                const SectionHeader(title: "Market"),
                if (snapshot.connectionState != ConnectionState.done)
                  const Expanded(
                    child: Column(children: [LinearProgressIndicator()]),
                  ),
                if (snapshot.connectionState == ConnectionState.done)
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        TradeGood good = snapshot.data!.tradeGoods[index];
                        return ListTile(
                          leading: Icon(
                            switch (good.supply) {
                              Supply.SCARCE => SpaceTradersIcons.scarce,
                              Supply.LIMITED => SpaceTradersIcons.limited,
                              Supply.MODERATE => SpaceTradersIcons.moderate,
                              Supply.ABUNDANT => SpaceTradersIcons.abundant,
                            },
                            size: 40,
                          ),
                          title: Text(good.symbol),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Sell: ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    children: [
                                      TextSpan(
                                        text: "${good.sellPrice}c/unit",
                                        style: const TextStyle(
                                          color: green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Buy: ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    children: [
                                      TextSpan(
                                        text: "${good.purchasePrice}c/unit",
                                        style: const TextStyle(
                                          color: red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                          trailing: ElevatedButton(
                            onPressed: () =>
                                showPurchaseSheet(context, good, ship),
                            child: const Text("Buy"),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.tradeGoods.length,
                    ),
                  ),
                Consumer<FleetProvider>(builder: (context, provider, _) {
                  final fuel = provider.getBySymbol(ship.symbol).fuel;
                  return RefuelButton(
                    tradeGoods: snapshot.data?.tradeGoods ?? [],
                    unitToResplenish: fuel.capacity - fuel.current,
                    onRefuel: () => provider.refuel(ship),
                  );
                })
              ],
            );
          },
        ),
      ),
    );
  }
}

void showSellingSheet(
  BuildContext context,
  CargoItem item,
  Ship ship, {
  int? pricePerUnit,
}) =>
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GoodExhangeSheet(
          label: 'Sell',
          goodSymbol: item.symbol,
          goodDescription: item.description,
          max: item.units,
          pricePerUnit: pricePerUnit,
          onConfirm: (int units) {
            final agentProvider = Provider.of<AgentProvider>(
              context,
              listen: false,
            );

            return Provider.of<FleetProvider>(context, listen: false)
                .sell(ship, item, units)
                .then(agentProvider.updateCredits)
                .then(Navigator.of(context).pop);
          },
        ),
      ),
    );

void showPurchaseSheet(
  BuildContext context,
  TradeGood good,
  Ship ship,
) =>
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GoodExhangeSheet(
          label: 'Buy',
          goodSymbol: good.symbol,
          max: good.tradeVolume,
          pricePerUnit: good.purchasePrice * -1,
          onConfirm: (int units) {
            final agentProvider = Provider.of<AgentProvider>(
              context,
              listen: false,
            );

            return Provider.of<FleetProvider>(context, listen: false)
                .purchase(
                  ship,
                  CargoItemSummary(symbol: good.symbol, units: units),
                )
                .then(agentProvider.updateCredits)
                .then(Navigator.of(context).pop);
          },
        ),
      ),
    );
