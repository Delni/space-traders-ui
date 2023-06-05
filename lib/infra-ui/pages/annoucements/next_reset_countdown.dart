import 'package:flutter/material.dart';
import 'package:space_traders/domain/server-status/status.dart';

class NextResetCountdown extends StatelessWidget {
  final AsyncSnapshot<ServerStatus> snapshot;
  const NextResetCountdown({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState != ConnectionState.done ||
        snapshot.data == null) {
      return const Center(
        child: LinearProgressIndicator(),
      );
    }
    final diff = snapshot.data!.nextReset.difference(DateTime.now());
    final next = diff.inDays <= 1 ? diff.toString() : "${diff.inDays} days";
    return Center(child: Text("Next reset in $next"));
  }
}
