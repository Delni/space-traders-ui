import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/components/good_exchange_sheet.dart';
import 'package:space_traders/infra-ui/components/mixins/route_args.mixin.dart';
import 'package:space_traders/infra-ui/pages/ship/components/cargo/ship_cargo_column.dart';
import 'package:space_traders/infra-ui/providers/fleet.provider.dart';

class ShipCargoPage extends StatelessWidget with RouteArgsMixin<String> {
  static const route = "/ship/cargo";

  const ShipCargoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(parseRoute(context))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Consumer<FleetProvider>(
            builder: (context, provider, child) => ShipCargoColumn(
              cargo: provider.getBySymbol(parseRoute(context)).cargo,
              action: (item) => ElevatedButton(
                onPressed: () => showJettisonSheet(context, item,
                    ship: provider.getBySymbol(parseRoute(context))),
                child: const Text('Jettison'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showJettisonSheet(BuildContext context, CargoItem item,
        {required Ship ship}) =>
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GoodExhangeSheet(
          label: 'Jettison',
          goodSymbol: item.symbol,
          goodDescription: item.description,
          max: item.units,
          onConfirm: (int units) =>
              Provider.of<FleetProvider>(context, listen: false)
                  .jettison(ship, item.withUnits(units))
                  .then(Navigator.of(context).pop),
        ),
      ),
    );
