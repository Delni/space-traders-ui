import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/infra-ui/adapters.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';
import 'package:space_traders/main.dart';

import 'mocks/agent.inMemory.dart';
import 'mocks/server.inMemory.dart';

void registerAllInMemoryAdapters() {
  Adapters.saveTokenAdapter = (token) {};
  Adapters.serverAdapter = ServerInMemoryAdapter();
  Adapters.agentAdapter = AgentInMemoryAdapter();
}

class TestApp extends StatelessWidget {
  final Widget testing;

  const TestApp({super.key, required this.testing});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AgentProvider())],
      child: MaterialApp(
        home: testing,
        routes: routes,
      ),
    );
  }
}
