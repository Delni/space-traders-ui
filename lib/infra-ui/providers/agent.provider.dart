import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:space_traders/domain/agent/agent.dart';
import 'package:space_traders/domain/contract.dart';
import 'package:space_traders/infra-ui/adapters.dart';

class AgentProvider extends ChangeNotifier {
  late Agent agent;

  List<Contract>? _contracts;

  UnmodifiableListView<Contract> get contracts =>
      UnmodifiableListView(_contracts ?? []);
  bool get initialized => _contracts != null;

  Future<Agent> getMe() => Adapters.agentAdapter.getMe().then((value) {
        agent = value;
        notifyListeners();
        return value;
      });

  void updateCredits(int credits) {
    agent = agent.copyWith(credits: agent.credits + credits);
    notifyListeners();
  }

  Future<void> loadContracts() => Adapters.agentAdapter
      .getMyContracts()
      .then((value) => _contracts = value.toList())
      .then((_) => notifyListeners());

  Future<void> accept(Contract contract) =>
      Adapters.agentAdapter.accept(contract).then((c) {
        final contractIndex = contracts.indexWhere(
          (element) => element.id == c.id,
        );
        _contracts?.replaceRange(contractIndex, contractIndex + 1, [c]);
        return c.terms.payment.onAccepted;
      }).then(updateCredits);
}
