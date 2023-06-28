import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/pages/ship/ship_cargo_item_sell_sheet.dart';

class ShipCargoItem extends StatelessWidget {
  final CargoItem item;
  final Ship ship;
  final Future<bool> canSell;

  const ShipCargoItem({
    super.key,
    required this.item,
    required this.canSell,
    required this.ship,
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
      trailing: FutureBuilder(
        future: canSell,
        builder: (context, snapshot) => ElevatedButton(
          onPressed: snapshot.hasData && snapshot.data!
              ? () => showSellingSheet(context, item, ship)
              : null,
          child: const Text('Sell'),
        ),
      ),
    );
  }
}

void showSellingSheet(BuildContext context, CargoItem item, Ship ship) =>
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ShipCargoItemSellSheet(
          item: item,
          ship: ship,
        ),
      ),
    );
