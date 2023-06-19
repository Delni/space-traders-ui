import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/infra-ui/pages/home/ship_summary.dart';
import 'package:space_traders/infra-ui/providers/fleet.provider.dart';

class Fleet extends StatelessWidget {
  const Fleet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FleetProvider>(builder: (ctx, provider, __) {
      if (!provider.initialized) {
        provider.loadFleet();
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your fleet",
            style: Theme.of(ctx).textTheme.headlineLarge,
          ),
          if (!provider.initialized) const LinearProgressIndicator(),
          ...provider.fleet.take(5).map((ship) => ShipSummary(ship: ship))
        ],
      );
    });
  }
}
