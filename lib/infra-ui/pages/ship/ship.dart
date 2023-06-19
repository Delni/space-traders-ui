import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';

class ShipPageArguments {
  final Ship ship;

  ShipPageArguments({required this.ship});
}

class ShipPage extends StatelessWidget {
  static const route = "/ships/details";

  const ShipPage({super.key});
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ShipPageArguments;
    final ship = args.ship;

    return Scaffold(
      appBar: AppBar(
        title: Text(ship.symbol),
      ),
    );
  }
}
