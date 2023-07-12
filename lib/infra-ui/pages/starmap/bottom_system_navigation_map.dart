import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/navigation.dart';
import 'package:space_traders/infra-ui/components/pallette.dart';
import 'package:space_traders/infra-ui/components/section_header.dart';
import 'package:space_traders/infra-ui/pages/starmap/waypoint/waypoint_tile.dart';
import 'package:space_traders/infra-ui/providers/starmap.provider.dart';

import 'system_map.dart';

Future<NavPoint?> showBottomSystemNavigationMap(
  BuildContext context,
  String systemSymbol,
) =>
    showModalBottomSheet<NavPoint>(
      context: context,
      builder: (context) =>
          Consumer<StarMapProvider>(
        builder: (context, provider, _) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            color: lightWhite.withOpacity(0.1),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: SystemNavigationMap(
                futureSystem: provider.get(systemSymbol),
                onNavigate: (navpoint) => Navigator.of(context).pop(navpoint),
              ),
            ),
          ),
        ),
      ),
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
  System? system;
  late Timer timer;
  Matrix4 transform = Matrix4.identity()
    ..rotateX(pi / 2)
    ..rotateZ(pi / 2);

  @override
  void initState() {
    widget.futureSystem.then((value) {
      setState(() {
        system = value;
      });
      timer = Timer(const Duration(milliseconds: 200), () {
        setState(() {
          transform = Matrix4.identity()
            ..rotateX(pi / 3)
            ..rotateZ(pi / 4);
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: InteractiveViewer(
              maxScale: 10,
              child: system != null
                  ? AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastEaseInToSlowEaseOut,
                      transformAlignment: Alignment.center,
                      transform: transform,
                      child: SystemMap(
                        transform: transform,
                        waypoints: system!.waypoints,
                      ),
                    )
                  : const LinearProgressIndicator(),
            ),
          ),
          const SectionHeader(title: "System Map"),
          if (system != null)
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Card(
                  child: WayPointTile(
                    waypoint: system!.waypoints[index],
                  ),
                ),
                itemCount: system!.waypoints.length,
              ),
            )
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
