import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:space_traders/domain/market.dart';
import 'package:space_traders/domain/navigation.dart';
import 'package:space_traders/domain/navigation/waypoint_trait.dart';
import 'package:space_traders/infra-ui/adapters.dart';

typedef RawDTO = Map<String, dynamic>;

class StarMapProvider extends ChangeNotifier {
  final HashMap<String, System> _systems = HashMap();

  Future<System> get(String systemSymbol) => _systems.containsKey(systemSymbol)
      ? Future.value(_systems[systemSymbol]!)
      : Adapters.navigationAdapter
          .getSystem(systemSymbol)
          .then(_enrichSystemWaypoints)
          .then((value) => _systems.putIfAbsent(systemSymbol, () => value))
          .whenComplete(notifyListeners);

  Future<Waypoint> getWaypoint(String waypointSymbol) =>
      get(waypointSymbol.split('-').take(2).join('-'))
          .then((value) => value.allWaypoints)
          .then(
            (value) =>
                value.firstWhere((element) => element.symbol == waypointSymbol),
          );

  Future<Market?> findMarket(String waypointSymbol) =>
      Adapters.navigationAdapter.findMarket(waypointSymbol);

  Future<Iterable<PurchasableShip>?> findShipyard(String waypointSymbol) =>
      Adapters.navigationAdapter.findShipyard(waypointSymbol);

  Future<System> _enrichSystemWaypoints(System system) async {
    Iterable<Map<String, dynamic>> rawWaypoints =
        await Adapters.navigationAdapter.getRawWaypoints(system.symbol);

    Iterable<String> children = rawWaypoints
        .expand((element) => List.from(element['orbitals']))
        .map((e) => e['symbol'] as String);

    List<Waypoint> actualWaypoints = system.waypoints
        .map((wp) => wp
          ..traits.addAll(_buildTraitsFrom(
            rawWaypoints,
            waypointSymbol: wp.symbol,
          ))
          ..orbitals.addAll(_buildOrbitalsFrom(
            rawWaypoints,
            waypointSymbol: wp.symbol,
            waypoints: system.waypoints,
          )))
        .where((element) => !children.contains(element.symbol))
        .toList();

    return system.copyWith(waypoints: actualWaypoints);
  }

  Iterable<Waypoint> _buildOrbitalsFrom(
    Iterable<RawDTO> rawWaypoints, {
    required String waypointSymbol,
    required List<Waypoint> waypoints,
  }) =>
      List.from(_getRawFor(waypointSymbol)(rawWaypoints)['orbitals'])
          .map((orbital) => orbital['symbol'])
          .map((orbitalSymbol) => waypoints.firstWhere(
                (element) => orbitalSymbol == element.symbol,
              ));

  Iterable<WaypointTrait> _buildTraitsFrom(
    Iterable<RawDTO> rawWaypoints, {
    required String waypointSymbol,
  }) =>
      List.from(_getRawFor(waypointSymbol)(rawWaypoints)['traits'])
          .map((trait) => WaypointTrait.fromJson(trait));

  RawDTO Function(Iterable<RawDTO>) _getRawFor(String waypointSymbol) =>
      (Iterable<RawDTO> rawWaypoints) => rawWaypoints.firstWhere(
            (element) => element['symbol'] == waypointSymbol,
          );
}
