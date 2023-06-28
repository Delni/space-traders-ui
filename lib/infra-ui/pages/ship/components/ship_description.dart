import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';

class ShipDescription extends StatelessWidget {
  final Ship ship;
  const ShipDescription({super.key, required this.ship});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ship.frame.symbol.name),
            Text(
              ship.frame.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
