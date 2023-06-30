import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';

class ShipActionsBar extends StatelessWidget {
  final Ship ship;
  final void Function()? onRefuel;
  final void Function()? onNavigate;

  const ShipActionsBar({
    super.key,
    required this.ship,
    this.onRefuel,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: ship.nav.status == ShipStatus.docked ? onRefuel : null,
            child: const Text('Refuel'),
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
