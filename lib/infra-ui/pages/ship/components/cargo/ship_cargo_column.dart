import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/components/section_header.dart';

import 'ship_cargo_item.dart';

class ShipCargoColumn extends StatelessWidget {
  final Cargo cargo;
  final ElevatedButton Function(CargoItem item)? action;

  const ShipCargoColumn({super.key, required this.cargo, this.action});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: 'Cargo',
          actions: [Text('${cargo.units}/${cargo.capacity}')],
        ),
        if (cargo.inventory.isEmpty)
          Text(
            "Cargo is empty",
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15),
          ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => ShipCargoItem(
              item: cargo.inventory[index],
              action: action != null ? action!(cargo.inventory[index]) : null,
            ),
            itemCount: cargo.inventory.length,
          ),
        )
      ],
    );
  }
}
