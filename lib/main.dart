import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/infra-ui/pages/home/home.dart';
import 'package:space_traders/infra-ui/pages/login/login.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';

void main() {
  runApp(const MainApp());
}

Map<String, WidgetBuilder> routes = {
  '/home': (context) => const HomePage(),
};

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AgentProvider())],
      child: MaterialApp(
        home: const LoginPage(),
        routes: routes,
      ),
    );
  }
}
