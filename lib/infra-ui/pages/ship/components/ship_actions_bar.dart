import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/components/button_with_cooldown.dart';

class ShipActionsBar extends StatelessWidget {
  final Ship ship;
  final void Function()? onOrbit;
  final void Function()? onDock;
  final void Function()? onRefuel;
  final Future<Cooldown> Function()? onExtract;
  final void Function()? onNavigate;

  const ShipActionsBar({
    super.key,
    required this.ship,
    this.onOrbit,
    this.onDock,
    this.onRefuel,
    this.onExtract,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (ship.nav.status == ShipStatus.inOrbit)
            ElevatedButton(
              onPressed: onDock,
              child: const Text('Dock'),
            ),
          if (ship.nav.status == ShipStatus.docked)
            ElevatedButton(
              onPressed: onOrbit,
              child: const Text('Orbit'),
            ),
          ElevatedButton(
            onPressed: ship.nav.status == ShipStatus.docked ? onRefuel : null,
            child: const Text('Refuel'),
          ),
          ButtonWithCoolDown(
            onPressed: ship.nav.status == ShipStatus.inOrbit ? onExtract : null,
            child: const Text('Extract'),
          ),
          ElevatedButton(
            onPressed:
                ship.nav.status == ShipStatus.inOrbit ? onNavigate : null,
            child: const Text('Navigate'),
          ),
        ],
      ),
    );
  }
}
