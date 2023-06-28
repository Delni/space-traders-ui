import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';

class ShipIcon extends StatelessWidget {
  final Ship ship;
  final double angle;
  final double opacity;
  final bool expand;

  const ShipIcon({
    super.key,
    required this.ship,
    double? angle,
    double? opacity,
    bool? expand,
  })  : angle = angle ?? 0,
        opacity = opacity ?? 1,
        expand = expand ?? false;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey("${ship.symbol}_icon"),
      child: Opacity(
        opacity: opacity,
        child: Transform.rotate(angle: angle, child: getIcon(context)),
      ),
    );
  }

  Widget getIcon(BuildContext context) => switch (ship.frame.symbol) {
        ShipFrames.PROBE => Image.asset(
            "assets/images/Probe.png",
            height: expand ? MediaQuery.of(context).size.height : null,
            fit: BoxFit.fitHeight,
          ),
        ShipFrames.DRONE => Image.asset(
            "assets/images/Drone.png",
            height: expand ? MediaQuery.of(context).size.height : null,
            fit: BoxFit.fitHeight,
          ),
        ShipFrames.FRIGATE => Image.asset(
            "assets/images/Frigate.png",
            height: expand ? MediaQuery.of(context).size.height : null,
            fit: BoxFit.fitHeight,
          ),
        _ => const Icon(Icons.rocket_rounded),
      };
}
