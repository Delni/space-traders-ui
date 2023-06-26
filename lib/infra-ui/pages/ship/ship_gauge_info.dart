import 'dart:math';

import 'package:flutter/material.dart';

class ShipGaugeInfo extends StatelessWidget {
  final String label;
  final num units;
  final num capacity;

  const ShipGaugeInfo(
      {super.key,
      required this.label,
      required this.units,
      required this.capacity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("$units/$capacity"),
              SizedBox(
                width: 100.0,
                child: LinearProgressIndicator(value: units / max(capacity, 1)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
