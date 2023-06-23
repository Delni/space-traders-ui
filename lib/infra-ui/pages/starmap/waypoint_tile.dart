import 'package:flutter/material.dart';
import 'package:space_traders/domain/navigation.dart';

class WayPointTile extends StatelessWidget {
  final Waypoint waypoint;

  const WayPointTile({super.key, required this.waypoint});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(waypoint.type.label),
              ),
              Expanded(child: Text(waypoint.name)),
              ElevatedButton(
                child: const Text('Navigate'),
                onPressed: () => Navigator.of(context).pop(
                  NavPoint.fromWaypoint(waypoint),
                ),
              ),
            ],
          ),
          if (waypoint.orbitals.isNotEmpty) Divider(),
          ...waypoint.orbitals.map((e) => WayPointTile(waypoint: e))
        ],
      ),
    );
    return ListTile(
      title: Text(waypoint.name),
      leading: Text(waypoint.type.label),
      trailing: ElevatedButton(
        child: const Text('Navigate'),
        onPressed: () => Navigator.of(context).pop(
          NavPoint.fromWaypoint(waypoint),
        ),
      ),
      subtitle: Column(
        children:
            waypoint.orbitals.map((e) => WayPointTile(waypoint: e)).toList(),
      ),
    );
  }
}
