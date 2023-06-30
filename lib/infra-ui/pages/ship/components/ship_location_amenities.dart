import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/navigation/waypoint.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/components/button_with_cooldown.dart';
import 'package:space_traders/infra-ui/pages/starmap/market_place.dart';
import 'package:space_traders/infra-ui/providers/starmap.provider.dart';

class ShipLocationAmenities extends StatelessWidget {
  final Ship ship;
  final Future<Cooldown> Function() onExtract;
  final Future Function() onNavigate;

  const ShipLocationAmenities({
    super.key,
    required this.ship,
    required this.onExtract,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StarMapProvider>(builder: (context, provider, _) {
      return FutureBuilder(
        future: provider.getWaypoint(ship.nav.waypointSymbol),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return const LinearProgressIndicator();
          }
          final waypoint = snapshot.data;
          if (waypoint == null) {
            return const LinearProgressIndicator();
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(waypoint.symbol),
                    Text(waypoint.type.label),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Status"),
                  Text(ship.nav.status.label),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: Text("In Orbit")),
                          ),
                          if (waypoint.isExtractable)
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ButtonWithCoolDown(
                                onPressed: ship.inOrbit ? onExtract : null,
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text("Extract"),
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: OutlinedButton(
                              onPressed: ship.inOrbit ? onNavigate : null,
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text("Navigate"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: Text("On Docks")),
                          ),
                          if (waypoint.hasMarketplace)
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: OutlinedButton(
                                onPressed: ship.isDocked
                                    ? () => Navigator.of(context).pushNamed(
                                          MarketPlacePage.route,
                                          arguments: ship,
                                        )
                                    : null,
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text("Access Market"),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    });
  }
}
