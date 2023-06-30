import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/infra-ui/pages/ship/components/cargo/ship_cargo.page.dart';
import 'package:space_traders/infra-ui/providers/fleet.provider.dart';

import 'ship_gauge_info.dart';

class ShipStatusSummary extends StatelessWidget {
  final String shipSymbol;

  const ShipStatusSummary({super.key, required this.shipSymbol});

  @override
  Widget build(BuildContext context) {
    return Consumer<FleetProvider>(builder: (context, provider, _) {
      final ship = provider.getBySymbol(shipSymbol);
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShipGaugeInfo(
              label: "Fuel",
              units: ship.fuel.current,
              capacity: ship.fuel.capacity,
            ),
            ShipGaugeInfo(
              label: "Cargo",
              units: ship.cargo.units,
              capacity: ship.cargo.capacity,
              onPressed: () => Navigator.of(context).pushNamed(
                ShipCargoPage.route,
                arguments: ship.symbol,
              ),
            ),
            ShipGaugeInfo(
              label: "Frame",
              units: ship.frame.condition,
              capacity: 100,
            ),
            ShipGaugeInfo(
              label: "Crew",
              units: ship.crew.current,
              capacity: ship.crew.capacity,
            ),
          ],
        ),
      );
    });
  }
}
