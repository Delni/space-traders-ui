import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:space_traders/domain/navigation.dart';
import 'package:space_traders/infra-ui/adapters.dart';

class StarMapProvider extends ChangeNotifier {
  final HashMap<String, System> _systems = HashMap();

  Future<System> get(String systemSymbol) => _systems.containsKey(systemSymbol)
      ? Future.value(_systems[systemSymbol]!)
      : Adapters.navigationAdapter
          .getSystem(systemSymbol)
          .then((value) async {
            List<Map<String, dynamic>> rawWaypoints =
                await Adapters.navigationAdapter.getRawWaypoints(systemSymbol);

            Iterable<String> children = rawWaypoints
                .expand((element) => List.from(element['orbitals']))
                .map((e) => e['symbol'] as String);

            List<Waypoint> actualWaypoints = value.waypoints
                .map((wp) => wp
                  ..orbitals.addAll(
                    List.from(rawWaypoints.firstWhere((element) =>
                            element['symbol'] == wp.symbol)['orbitals'])
                        .map((orbital) => orbital['symbol'])
                        .map(
                          (orbitalSymbol) => value.waypoints.firstWhere(
                            (element) => orbitalSymbol == element.symbol,
                          ),
                        ),
                  ))
                .where((element) => !children.contains(element.symbol))
                .toList();

            return value.copyWith(waypoints: actualWaypoints);
          })
          .then((value) => _systems.putIfAbsent(systemSymbol, () => value))
          .whenComplete(notifyListeners);
}
