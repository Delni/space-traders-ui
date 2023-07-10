import 'dart:async';

import 'package:flutter/material.dart';
import 'package:space_traders/infra-ui/components/mixins/duration_to_string.mixin.dart';

class Countdown extends StatefulWidget {
  final DateTime date;
  final TextStyle? style;

  const Countdown({super.key, required this.date, this.style});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> with DurationToString {
  late Timer timer;
  late Duration remaining;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateRemaining();
    });
    updateRemaining();
    super.initState();
  }

  void updateRemaining() {
    setState(() {
      remaining = widget.date.difference(DateTime.now().toUtc());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timeDiffToString(remaining),
      style: widget.style,
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
