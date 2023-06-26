import 'dart:async';

import 'package:flutter/material.dart';
import 'package:space_traders/domain/ship.dart';

import 'animated_cooldown_progress.dart';

class ButtonWithCoolDown extends StatefulWidget {
  final Future<Cooldown> Function()? onPressed;
  final Widget child;

  const ButtonWithCoolDown({
    super.key,
    this.onPressed,
    required this.child,
  });

  @override
  State<ButtonWithCoolDown> createState() => _ButtonWithCoolDownState();
}

class _ButtonWithCoolDownState extends State<ButtonWithCoolDown>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    ));
    super.initState();
  }

  void setCooldown(Cooldown value) {
    controller.reset();
    controller.duration = Duration(seconds: value.remainingSeconds);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCooldownProgress(
      onPressed: widget.onPressed == null
          ? null
          : () => widget.onPressed!().then(setCooldown),
      listenable: animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
