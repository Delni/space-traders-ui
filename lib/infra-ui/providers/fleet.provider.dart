import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:space_traders/domain/entity.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/adapters.dart';

class FleetProvider extends ChangeNotifier {
  List<Ship>? _fleet;

  UnmodifiableListView<Ship> get fleet => UnmodifiableListView(_fleet ?? []);
  bool get initialized => _fleet != null;

  Future<void> loadFleet() => Adapters.shipAdapter
      .getMyShips()
      .then((value) => _fleet = value.toList())
      .then((_) => notifyListeners());

  Ship getBySymbol(String symbol) => fleet.firstWhere(hasSymbol(symbol));
  int indexOf(Ship ship) => fleet.indexWhere(hasSymbol(ship.symbol));

  Future<void> orbitOrDock(Ship ship) => Adapters.shipAdapter
      .orbitOrDock(
        ship: ship,
        waypointSymbol: ship.nav.waypointSymbol,
        to: ship.nav.status == ShipStatus.docked
            ? ShipStatus.inOrbit
            : ShipStatus.docked,
      )
      .then((value) => fleet[indexOf(ship)].copyWith(nav: value))
      .then((value) => _fleet![indexOf(ship)] = value)
      .then((value) => notifyListeners());
}
