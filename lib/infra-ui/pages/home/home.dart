import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/infra-ui/pages/home/agent_banner.dart';
import 'package:space_traders/infra-ui/pages/home/fleet.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Consumer<AgentProvider>(
          builder: (context, value, child) => AgentBanner(agent: value.agent),
        ),
      ),
      body: ListView(
        children: const [Fleet()],
      ),
    );
  }
}
