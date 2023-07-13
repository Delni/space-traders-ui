import 'package:flutter/material.dart';
import 'package:space_traders/infra-ui/pages/starmap/market_place.dart';
import 'package:space_traders/infra-ui/pages/starmap/shipyard.dart';

import 'amenities.dart';

class DockedAmenities extends AmenitiesWidget {
  const DockedAmenities({
    super.key,
    required super.waypoint,
    required super.ship,
    required super.orbitOrDockButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        orbitOrDockButton,
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
        if (waypoint.hasShipyard)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: OutlinedButton(
              onPressed: ship.isDocked
                  ? () => Navigator.of(context).pushNamed(
                        ShipyardPage.route,
                        arguments: ship.nav.waypointSymbol,
                      )
                  : null,
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Access Shipyard"),
              ),
            ),
          ),
      ],
    );
  }
}
