import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';

import 'ship_gauge_info.dart';

class ShipStatusSummary extends StatelessWidget {
  final Ship ship;

  const ShipStatusSummary({super.key, required this.ship});

  @override
  Widget build(BuildContext context) {
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
  }
}
