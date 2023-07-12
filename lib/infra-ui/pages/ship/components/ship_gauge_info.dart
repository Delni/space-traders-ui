import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ShipGaugeInfo extends StatelessWidget {
  final String label;
  final num units;
  final num capacity;
  final void Function()? onPressed;

  const ShipGaugeInfo({
    super.key,
    required this.label,
    required this.units,
    required this.capacity,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 5 - 8,
            child: AspectRatio(
              aspectRatio: 1 / 1.5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text("$units"),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 9,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: CircularProgressIndicator(
                              value: capacity == 0 ? 1 : units / capacity,
                              strokeWidth:
                                  MediaQuery.of(context).size.width / 125,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      label,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            fontSize: MediaQuery.of(context).size.width / 30,
                          ),
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
