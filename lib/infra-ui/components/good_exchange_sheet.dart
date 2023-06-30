import 'package:flutter/material.dart';
import 'package:space_traders/infra-ui/components/future_button.dart';
import 'package:space_traders/infra-ui/components/pallette.dart';

class GoodExhangeSheet extends StatefulWidget {
  final Future Function(int units) onConfirm;
  final String label;
  final String goodSymbol;
  final String? goodDescription;
  final int max;
  final int? pricePerUnit;

  const GoodExhangeSheet({
    super.key,
    required this.label,
    required this.goodSymbol,
    required this.onConfirm,
    required this.max,
    this.pricePerUnit,
    this.goodDescription,
  });

  @override
  State<GoodExhangeSheet> createState() => _GoodExhangeSheetState();
}

class _GoodExhangeSheetState extends State<GoodExhangeSheet> {
  int units = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "${widget.label} ${widget.goodSymbol}",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(widget.goodDescription ?? ""),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
          child: Row(
            children: [
              Expanded(
                child: Slider(
                  value: units.toDouble(),
                  onChanged: (value) => setState(() {
                    units = value.toInt();
                  }),
                  max: widget.max.toDouble(),
                  min: 1,
                  divisions: widget.max - 1,
                ),
              ),
              Column(
                children: [
                  Text(
                    units.toString().padLeft(widget.max.toString().length, '0'),
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontFamily: 'Plastique'),
                  ),
                  if (widget.pricePerUnit != null)
                    Text(
                      "${widget.pricePerUnit!.sign > 0 ? '+' : '-'}${widget.pricePerUnit!.abs() * units}c",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                widget.pricePerUnit!.isNegative ? red : green,
                          ),
                    )
                ],
              ),
            ],
          ),
        ),
        ButtonBar(
          children: [
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FutureButton(
              onPressed: () {
                setState(() {
                  units = widget.max;
                });
                return widget.onConfirm(units);
              },
              label: '${widget.label} All',
            ),
            FutureButton(
              onPressed: () => widget.onConfirm(units),
              label: widget.label,
            ),
          ],
        )
      ],
    );
  }
}
