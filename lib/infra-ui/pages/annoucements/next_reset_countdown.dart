import 'dart:async';

import 'package:flutter/material.dart';
import 'package:space_traders/domain/server-status/status.dart';

class NextResetCountdown extends StatefulWidget {
  final AsyncSnapshot<ServerStatus> snapshot;
  const NextResetCountdown({super.key, required this.snapshot});

  @override
  State<NextResetCountdown> createState() => _NextResetCountdownState();
}

class _NextResetCountdownState extends State<NextResetCountdown> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.connectionState != ConnectionState.done ||
        widget.snapshot.data == null) {
      return const Center(
        child: LinearProgressIndicator(),
      );
    }
    final diff = widget.snapshot.data!.nextReset.difference(DateTime.now());
    final next = timeDiffToString(diff);
    return Center(child: Text("Next reset in $next"));
  }

  String timeDiffToString(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours - duration.inDays * 24;
    final minutes = duration.inMinutes - duration.inHours * 60;
    final seconds = duration.inSeconds - duration.inMinutes * 60;
    return [
      if (days > 0) "$days days and",
      if (hours > 0) "$hours hours",
      if (minutes > 0) "$minutes min",
      if (seconds > 0) "$seconds s",
    ].join(" ");
  }
}
