import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/navigation/waypoint.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/components/future_button.dart';
import 'package:space_traders/infra-ui/pages/ship/components/amenities/docked_amenities.dart';
import 'package:space_traders/infra-ui/pages/ship/components/amenities/in_orbit_amenities.dart';
import 'package:space_traders/infra-ui/providers/starmap.provider.dart';

class ShipLocationAmenities extends StatefulWidget {
  final Ship ship;
  final Future Function() onOrbitOrDock;
  final Future<Cooldown> Function() onExtract;
  final Future Function() onNavigate;

  const ShipLocationAmenities({
    super.key,
    required this.ship,
    required this.onExtract,
    required this.onNavigate,
    required this.onOrbitOrDock,
  });

  @override
  State<ShipLocationAmenities> createState() => _ShipLocationAmenitiesState();
}

class _ShipLocationAmenitiesState extends State<ShipLocationAmenities> {
  PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    Timer(const Duration(milliseconds: 10), updatePage);
    super.initState();
  }

  void updatePage() {
    setState(() {
      controller.animateToPage(widget.ship.isDocked ? 0 : 1,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutSine);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StarMapProvider>(builder: (context, provider, _) {
      final orbitOrDockButton = Padding(
        padding: const EdgeInsets.all(5.0),
        child: FutureButton(
          onPressed: () => widget.onOrbitOrDock().then((value) => updatePage()),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              widget.ship.isDocked ? 'Orbit' : 'Dock',
            ),
          ),
        ),
      );
      return FutureBuilder(
        future: provider.getWaypoint(widget.ship.nav.waypointSymbol),
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
                  Text(widget.ship.nav.status.label),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: controller,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InOrbitAmenities(
                        ship: widget.ship,
                        waypoint: waypoint,
                        onExtract: widget.onExtract,
                        onNavigate: widget.onNavigate,
                        orbitOrDockButton: orbitOrDockButton,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DockedAmenities(
                        ship: widget.ship,
                        waypoint: waypoint,
                        orbitOrDockButton: orbitOrDockButton,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
