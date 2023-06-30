import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/components/button_with_cooldown.dart';
import 'package:space_traders/infra-ui/pages/ship/components/amenities/amenities.dart';

class InOrbitAmenities extends AmenitiesWidget {
  final Future<Cooldown> Function() onExtract;
  final Future Function() onNavigate;

  const InOrbitAmenities({
    super.key,
    required super.waypoint,
    required super.ship,
    required super.orbitOrDockButton,
    required this.onExtract,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        orbitOrDockButton,
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
        ),
      ],
    );
  }
}
