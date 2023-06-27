import 'package:flutter/material.dart';
import 'package:space_traders/domain/agent/agent.dart';
import 'package:space_traders/infra-ui/adapters.dart';

class AgentProvider extends ChangeNotifier {
  late Agent agent;

  Future<Agent> getMe() => Adapters.agentAdapter.getMe().then((value) {
        agent = value;
        notifyListeners();
        return value;
      });

  void updateCredits(int credits) {
    agent = agent.copyWith(credits: agent.credits + credits);
    notifyListeners();
  }
}
