import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/infra-ui/pages/home/agent_banner.dart';
import 'package:space_traders/infra-ui/pages/home/contracts.dart';
import 'package:space_traders/infra-ui/pages/home/fleet.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';

class HomePage extends StatelessWidget {
  static const route = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<AgentProvider>(
          builder: (context, value, child) => AgentBanner(agent: value.agent),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            Fleet(),
            Contracts(),
          ],
        ),
      ),
    );
  }
}
