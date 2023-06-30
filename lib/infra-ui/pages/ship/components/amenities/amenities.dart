import 'package:flutter/material.dart';
import 'package:space_traders/domain/navigation.dart';
import 'package:space_traders/domain/ship.dart';

abstract class AmenitiesWidget extends StatelessWidget {
  final Widget orbitOrDockButton;
  final Waypoint waypoint;
  final Ship ship;

  const AmenitiesWidget({
    super.key,
    required this.orbitOrDockButton,
    required this.waypoint,
    required this.ship,
  });
}
