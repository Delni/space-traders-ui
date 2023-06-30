import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';

class ShipCargoItem extends StatelessWidget {
  final CargoItem item;
  final Ship ship;
  final ElevatedButton? action;

  const ShipCargoItem({
    super.key,
    required this.item,
    required this.ship,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        item.units.toString(),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 42),
      ),
      title: Text(item.name),
      subtitle: Text(item.description),
      trailing: action,
    );
  }
}
