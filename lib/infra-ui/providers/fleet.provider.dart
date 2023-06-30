import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:space_traders/domain/entity.dart';
import 'package:space_traders/domain/navigation.dart';
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

  Ship Function(Ship) _update(Ship ship) =>
      (value) => _fleet![indexOf(ship)] = value;

  int indexOf(Ship ship) => fleet.indexWhere(hasSymbol(ship.symbol));

  T Function(T) updateCargoOf<T extends WithCargo>(Ship ship) => (T value) {
        _fleet![indexOf(ship)] = ship.copyWith(cargo: value.cargo);
        notifyListeners();
        return value;
      };

  Future<void> navigateTo(NavPoint navpoint, Ship ship) => Adapters.shipAdapter
      .navigateTo(
        ship: ship,
        waypointSymbol: navpoint.symbol,
      )
      .then((value) => ship.copyWith(fuel: value.fuel, nav: value.nav))
      .then(_update(ship))
      .then(setShipInOrbitOnArrival)
      .then((value) => notifyListeners());

  Future<void> setShipInOrbitOnArrival(Ship ship) => Future.delayed(
        ship.nav.route.arrival.difference(ship.nav.route.departureTime),
        () {
          _fleet![indexOf(ship)] = ship.copyWith(
            nav: ship.nav.copyWith(status: ShipStatus.inOrbit),
          );
          notifyListeners();
        },
      );

  Future<void> refuel(Ship ship) => Adapters.shipAdapter
      .refuel(ship: ship, waypointSymbol: ship.nav.waypointSymbol)
      .then((value) => ship.copyWith(fuel: value))
      .then(_update(ship))
      .then((value) => notifyListeners());

  Future<Cooldown> extract(Ship ship) => Adapters.shipAdapter
      .extract(ship: ship, waypointSymbol: ship.nav.waypointSymbol)
      .then(updateCargoOf(ship))
      .then((value) => value.cooldown);

  Future<int> sell(Ship ship, CargoItem item, int units) => Adapters.shipAdapter
      .sell(ship: ship, goods: item.withUnits(units))
      .then(updateCargoOf(ship))
      .then((value) => value.transaction.totalPrice);

  Future<int> purchase(Ship ship, CargoItemSummary item) => Adapters.shipAdapter
      .purchase(ship: ship, goods: item)
      .then(updateCargoOf(ship))
      .then((value) => value.transaction.totalPrice * -1);

  Future<void> orbitOrDock(Ship ship) => Adapters.shipAdapter
      .orbitOrDock(
        ship: ship,
        waypointSymbol: ship.nav.waypointSymbol,
        to: ship.nav.status == ShipStatus.docked
            ? ShipStatus.inOrbit
            : ShipStatus.docked,
      )
      .then((value) => fleet[indexOf(ship)].copyWith(nav: value))
      .then(_update(ship))
      .then((value) => notifyListeners());
}
