import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/infra-ui/pages/home/home.dart';
import 'package:space_traders/infra-ui/pages/login/login.dart';
import 'package:space_traders/infra-ui/pages/ship/components/cargo/ship_cargo.page.dart';
import 'package:space_traders/infra-ui/pages/ship/ship.dart';
import 'package:space_traders/infra-ui/pages/starmap/market_place.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';
import 'package:space_traders/infra-ui/providers/fleet.provider.dart';
import 'package:space_traders/infra-ui/providers/starmap.provider.dart';

import 'infra-ui/components/pallette.dart';

void main() {
  runApp(const MainApp());
}

Map<String, WidgetBuilder> routes = {
  HomePage.route: (context) => const HomePage(),
  ShipPage.route: (context) => const ShipPage(),
  ShipCargoPage.route: (context) => const ShipCargoPage(),
  MarketPlacePage.route: (context) => const MarketPlacePage(),
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
          primaryColor: blue,
          scaffoldBackgroundColor: black,
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            circularTrackColor: lightWhite,
          ),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.transparent,
          ),
          cardTheme: const CardTheme(
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            color: transparentWhite,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(20),
                bottomEnd: Radius.circular(20),
              ),
              side: BorderSide(
                color: lightWhite,
                width: 0.5,
              ),
            ),
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: transparentWhite,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                bottomEnd: Radius.circular(20),
              ),
              side: BorderSide(
                color: lightWhite,
                width: 0.5,
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
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
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
            side: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return const BorderSide(color: lightWhite, width: 0.5);
              }
              return const BorderSide(color: blue, width: 0.5);
            }),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return lightWhite;
              }
              return white;
            }),
            shape: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
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
              ));
            }),
          )),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontFamily: 'BigMacca',
              color: white,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'BigMacca',
              color: white,
              fontSize: 32,
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
