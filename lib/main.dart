import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/infra-ui/pages/home/home.dart';
import 'package:space_traders/infra-ui/pages/login/login.dart';
import 'package:space_traders/infra-ui/pages/ship/ship.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';
import 'package:space_traders/infra-ui/providers/fleet.provider.dart';

void main() {
  runApp(const MainApp());
}

Map<String, WidgetBuilder> routes = {
  HomePage.route: (context) => const HomePage(),
  ShipPage.route: (context) => const ShipPage()
};

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AgentProvider()),
        ChangeNotifierProvider(create: (context) => FleetProvider()),
      ],
      child: MaterialApp(
        home: const LoginPage(),
        routes: routes,
      ),
    );
  }
}
