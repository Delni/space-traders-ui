import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/navigation.dart';
import 'package:space_traders/infra-ui/pages/starmap/waypoint_tile.dart';
import 'package:space_traders/infra-ui/providers/starmap.provider.dart';

import 'system_map.dart';

Future<NavPoint?> showBottomSystemNavigationMap(
        BuildContext context, String systemSymbol) =>
    showModalBottomSheet<NavPoint>(
      context: context,
      builder: (context) =>
          Consumer<StarMapProvider>(builder: (context, provider, _) {
        return SystemNavigationMap(
          futureSystem: provider.get(systemSymbol),
          onNavigate: (navpoint) => Navigator.of(context).pop(navpoint),
        );
      }),
    );

class SystemNavigationMap extends StatefulWidget {
  final Future<System> futureSystem;
  final Function(NavPoint) onNavigate;

  const SystemNavigationMap({
    super.key,
    required this.futureSystem,
    required this.onNavigate,
  });

  @override
  State<SystemNavigationMap> createState() => _SystemNavigationMapState();
}

class _SystemNavigationMapState extends State<SystemNavigationMap> {
  late Timer timer;
  Matrix4 transform = Matrix4.identity()
    ..rotateX(pi / 2)
    ..rotateZ(pi / 2);

  @override
  void initState() {
    timer = Timer(const Duration(milliseconds: 200), () {
      setState(() {
        transform = Matrix4.identity()
          ..rotateX(pi / 3)
          ..rotateZ(pi / 4);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: FutureBuilder<System>(
        future: widget.futureSystem,
        builder: (BuildContext context, AsyncSnapshot<System> snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: InteractiveViewer(
                  maxScale: 10,
                  child: snapshot.hasData
                      ? AnimatedContainer(
                          duration: const Duration(seconds: 2),
                          curve: Curves.fastEaseInToSlowEaseOut,
                          transformAlignment: Alignment.center,
                          transform: transform,
                          child: SystemMap(
                            transform: transform,
                            waypoints: snapshot.data!.waypoints,
                          ),
                        )
                      : const LinearProgressIndicator(),
                ),
              ),
              Text(
                "System Map",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              if (snapshot.hasData)
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) => Card(
                    child: WayPointTile(
                      waypoint: snapshot.data!.waypoints[index],
                    ),
                  ),
                  itemCount: snapshot.data!.waypoints.length,
                ))
            ],
          );
        },
      ),
    );
  }
}
