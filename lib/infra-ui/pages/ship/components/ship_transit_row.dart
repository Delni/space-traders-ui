import 'package:flutter/material.dart';
import 'package:space_traders/domain/navigation.dart';
import 'package:space_traders/infra-ui/components/mixins/duration_to_string.mixin.dart';

class ShipTransitRow extends StatefulWidget {
  final NavRoute route;

  const ShipTransitRow({super.key, required this.route});

  @override
  State<ShipTransitRow> createState() => _ShipTransitRowState();
}

class _ShipTransitRowState extends State<ShipTransitRow>
    with TimeDiffMixin, SingleTickerProviderStateMixin {
  late Animation<double> animation;

  @override
  void initState() {
    final controller = AnimationController(
      vsync: this,
      duration: durationSinceDepartureTo(widget.route.arrival),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    ));
    controller.forward(
      from: durationSinceDepartureTo(DateTime.now().toUtc()).inMicroseconds /
          durationSinceDepartureTo(widget.route.arrival).inMicroseconds,
    );

    super.initState();
  }

  Duration durationSinceDepartureTo(DateTime to) => timeDiff(
        from: widget.route.departureTime,
        to: to,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.route.departure.symbol),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedTransit(listenable: animation),
          ),
        ),
        Text(widget.route.destination.symbol),
      ],
    );
  }
}

class AnimatedTransit extends AnimatedWidget {
  const AnimatedTransit({super.key, required super.listenable});

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return LinearProgressIndicator(value: animation.value);
  }
}
