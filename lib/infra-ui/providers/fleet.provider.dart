import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';
import 'package:space_traders/infra-ui/adapters.dart';

class FleetProvider extends ChangeNotifier {
  List<Ship>? _fleet;

  UnmodifiableListView get fleet => UnmodifiableListView(_fleet ?? []);
  bool get initialized => _fleet != null;

  Future<void> loadFleet() => Adapters.shipAdapter
      .getMyShips()
      .then((value) => _fleet = value.toList())
      .then((_) => notifyListeners());
}
