import 'package:flutter/material.dart';
import 'package:space_traders/domain/navigation.dart';

import 'waypoint_tile_header.dart';

class WayPointTile extends StatelessWidget {
  final Waypoint waypoint;
  final bool? isChild;

  const WayPointTile({super.key, required this.waypoint, this.isChild});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (isChild ?? false)
          ? const EdgeInsets.symmetric(vertical: 4.0)
          : const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WaypointTileHeader(waypoint: waypoint),
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
