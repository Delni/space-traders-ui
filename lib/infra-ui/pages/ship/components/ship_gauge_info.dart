import 'dart:math';
import 'dart:ui';

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
      child: Card(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 120,
              child: AspectRatio(
                aspectRatio: 1 / 1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text("$units"),
                        CircularProgressIndicator(
                          value: units / max(capacity, 1),
                          strokeWidth: 2,
                        ),
                      ],
                    ),
                    Text(
                      label,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
