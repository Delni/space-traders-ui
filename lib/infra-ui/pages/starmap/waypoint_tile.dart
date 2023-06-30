import 'package:flutter/material.dart';
import 'package:space_traders/domain/navigation.dart';

class WayPointTile extends StatelessWidget {
  final Waypoint waypoint;
  final bool? isChild;

  const WayPointTile({super.key, required this.waypoint, this.isChild});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all((isChild ?? false) ? 0.0 : 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(waypoint.type.asDTO),
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
          // Row(
          //   children: [
          //     ...waypoint.traits
          //         .where((element) =>
          //             element.symbol == WaypointTraitSymbol.MARKETPLACE)
          //         .map((e) => const Icon(SpaceTradersIcons.market)),
          //     ...waypoint.traits
          //         .where((element) =>
          //             element.symbol == WaypointTraitSymbol.SHIPYARD)
          //         .map((e) => const Icon(SpaceTradersIcons.shipyard)),
          //   ],
          // ),
          
          if (waypoint.orbitals.isNotEmpty) const Divider(),
          ...waypoint.orbitals.map(
            (e) => Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.subdirectory_arrow_right_outlined),
                ),
                Expanded(
                  child: WayPointTile(
                    waypoint: e,
                    isChild: true,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
