import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/infra-ui/pages/home/home.dart';
import 'package:space_traders/infra-ui/pages/login/login.dart';
import 'package:space_traders/infra-ui/pages/ship/ship.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';
import 'package:space_traders/infra-ui/providers/fleet.provider.dart';
import 'package:space_traders/infra-ui/providers/starmap.provider.dart';

void main() {
  runApp(const MainApp());
}

Map<String, WidgetBuilder> routes = {
  HomePage.route: (context) => const HomePage(),
  ShipPage.route: (context) => const ShipPage(),
};

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AgentProvider()),
        ChangeNotifierProvider(create: (context) => FleetProvider()),
        ChangeNotifierProvider(create: (context) => StarMapProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xff2f81f7),
          scaffoldBackgroundColor: const Color(0xff0d1117),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            circularTrackColor: Color(0x85B7CEEE),
          ),
          cardTheme: const CardTheme(
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            color: Color(0x09C5C5F3),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(20),
                bottomEnd: Radius.circular(20),
              ),
              side: BorderSide(
                color: Color(0x85B7CEEE),
                width: 0.5,
              ),
            ),
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Color(0x09C5C5F3),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                bottomEnd: Radius.circular(20),
              ),
              side: BorderSide(
                color: Color(0x85B7CEEE),
                width: 0.5,
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith((states) {
              // If the button is pressed, return green, otherwise blue
              if (states.contains(MaterialState.pressed)) {
                return const BeveledRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(10),
                    bottomStart: Radius.circular(10),
                  ),
                );
              }
              return const BeveledRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(10),
                  bottomEnd: Radius.circular(10),
                ),
              );
            }),
          )),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontFamily: 'BigMacca',
              color: Color(0xffe6edf3),
            ),
            headlineMedium: TextStyle(
              fontFamily: 'BigMacca',
              color: Color(0xffe6edf3),
            ),
            headlineSmall: TextStyle(fontFamily: 'BigMacca'),
            bodyLarge: TextStyle(fontFamily: 'Plastique'),
            bodyMedium: TextStyle(fontFamily: 'Plastique'),
            bodySmall: TextStyle(fontFamily: 'Plastique'),
            titleLarge: TextStyle(fontFamily: 'Plastique'),
            titleMedium: TextStyle(fontFamily: 'Plastique'),
            titleSmall: TextStyle(fontFamily: 'Plastique'),
            labelLarge: TextStyle(fontFamily: 'Plastique'),
            labelMedium: TextStyle(fontFamily: 'Plastique'),
            labelSmall: TextStyle(fontFamily: 'Plastique'),
          ),
        ),
        home: const LoginPage(),
        routes: routes,
      ),
    );
  }
}
