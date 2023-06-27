import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/components/future_button.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';
import 'package:space_traders/infra-ui/providers/fleet.provider.dart';

class ShipCargoItemSellSheet extends StatefulWidget {
  final CargoItem item;
  final Ship ship;

  const ShipCargoItemSellSheet(
      {super.key, required this.item, required this.ship});

  @override
  State<ShipCargoItemSellSheet> createState() => _ShipCargoItemSellSheetState();
}

class _ShipCargoItemSellSheetState extends State<ShipCargoItemSellSheet> {
  int units = 1;

  Future<void> sell(BuildContext context) {
    final agentProvider = Provider.of<AgentProvider>(context, listen: false);

    return Provider.of<FleetProvider>(context, listen: false)
        .sell(widget.ship, widget.item, units)
        .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('+$value credits added to your wallet'),
          ));
          return value;
        })
        .then(agentProvider.updateCredits)
        .then(Navigator.of(context).pop);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Selling ${widget.item.name}",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(widget.item.description),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
          child: Row(
            children: [
              Expanded(
                child: Slider(
                  value: units.toDouble(),
                  onChanged: (value) => setState(() {
                    units = value.toInt();
                  }),
                  max: widget.item.units.toDouble(),
                  min: 1,
                  divisions: widget.item.units - 1,
                ),
              ),
              Text(
                units.toString().padLeft(3, '0'),
                style: Theme.of(context).textTheme.headlineMedium,
              )
            ],
          ),
        ),
        ButtonBar(
          children: [
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FutureButton(onPressed: () => sell(context), label: 'Sell'),
            FutureButton(
              onPressed: () {
                setState(() {
                  units = widget.item.units;
                });
                return sell(context);
              },
              label: 'Sell All',
            ),
          ],
        )
      ],
    );
  }
}
