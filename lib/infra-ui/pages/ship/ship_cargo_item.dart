import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';

class ShipCargoItem extends StatelessWidget {
  final CargoItem item;

  const ShipCargoItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.description),
      trailing: Text(
        item.units.toString(),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
