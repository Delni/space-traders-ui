import 'package:flutter/material.dart';
import 'package:space_traders/domain/agent.dart';

class AgentBanner extends StatelessWidget {
  final Agent agent;

  const AgentBanner({super.key, required this.agent});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(12)),
      ),
      shadowColor: Colors.blue,
      child: ListTile(
        title: Text("Greetings ${agent.symbol}"),
        subtitle: Text(agent.headquarters),
        trailing: Text("${agent.credits}c"),
      ),
    );
  }
}
