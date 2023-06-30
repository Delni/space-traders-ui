import 'dart:math';

import 'package:flutter/material.dart';
import 'package:space_traders/domain/navigation.dart';

double normalize(num value, num x0, num x1, num maximum) {
  return value * (x1 - x0) / maximum + x0;
}

class SystemMap extends StatelessWidget {
  final Iterable<Waypoint> waypoints;
  final Matrix4 transform;
  static const double iconSize = 20;

  const SystemMap({
    super.key,
    required this.waypoints,
    required this.transform,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LayoutBuilder(builder: (context, constraints) {
        return CustomPaint(
          size: Size(
            constraints.constrainWidth(),
            constraints.constrainHeight(),
          ),
          foregroundPainter: StarMapPainter(
            context: context,
            waypoints: waypoints,
            transform: transform,
          ),
          // child: const Placeholder(),
        );
      }),
    );
  }
}

class StarMapPainter extends CustomPainter {
  final Iterable<Waypoint> waypoints;
  final Matrix4 transform;
  final TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
  final BuildContext context;

  StarMapPainter(
      {required this.context,
      required this.transform,
      required this.waypoints});

  double get farestOrbit =>
      waypoints.map((e) => e.position.distance).reduce(max);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size / 2;
    final centerOffset = Offset(center.width, center.height);
    Paint starPaint = Paint()..color = Colors.amber;
    Paint planetPaint = Paint()
      ..color = Theme.of(context).textTheme.bodyMedium!.color!;
    Paint orbitPaint = Paint()
      ..color = planetPaint.color.withOpacity(0.5)
      ..style = PaintingStyle.stroke;

    drawCelestialBody(
      canvas,
      origin: centerOffset,
      painter: starPaint,
      radius: 15,
    );

    for (var waypoint in waypoints) {
      double orbitRadius = waypoint.position.distance * 2;
      double scaleFactor = (center.shortestSide) / farestOrbit * 1.5;
      Offset waypointToScale = waypoint.position * scaleFactor + centerOffset;

      canvas.drawOval(
        Rect.fromCenter(
          center: centerOffset,
          width: orbitRadius * scaleFactor,
          height: orbitRadius * scaleFactor,
        ),
        orbitPaint,
      );

      drawCelestialBody(
        canvas,
        origin: waypointToScale,
        painter: planetPaint,
        radius: 5,
        label: "${waypoint.name} – ${waypoint.type.asDTO}",
      );

      for (var i = 0; i < waypoint.orbitals.length; i++) {
        final orbital = waypoint.orbitals[i];
        canvas.drawOval(
          Rect.fromCenter(
            center: waypointToScale,
            width: 15 / 2 * scaleFactor,
            height: 15 / 2 * scaleFactor,
          ),
          orbitPaint,
        );
        drawCelestialBody(
          canvas,
          origin: waypointToScale +
              Offset.fromDirection(
                2 * pi * i / (waypoint.orbitals.length),
                15,
              ),
          painter: planetPaint,
          radius: 2,
          label: "${orbital.name} – ${orbital.type.asDTO}",
        );
      }
    }
  }

  void drawCelestialBody(
    Canvas canvas, {
    required Offset origin,
    required Paint painter,
    required double radius,
    String? label,
  }) {
    canvas.save();
    canvas.translate(origin.dx, origin.dy);
    canvas.transform(Matrix4.inverted(transform).storage);
    canvas.drawCircle(Offset.zero, radius, painter);
    textPainter.text = TextSpan(
      text: label,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: radius * 2,
          ),
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(2 * radius, -(radius + 1)));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant StarMapPainter oldDelegate) =>
      waypoints != oldDelegate.waypoints;
}
