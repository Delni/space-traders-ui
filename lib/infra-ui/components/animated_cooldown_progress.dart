import 'package:flutter/material.dart';

class AnimatedCooldownProgress extends AnimatedWidget {
  final Widget child;
  final void Function()? onPressed;

  const AnimatedCooldownProgress({
    super.key,
    required this.child,
    required this.onPressed,
    required Animation<double> super.listenable,
  });

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Stack(
      fit: StackFit.passthrough,
      children: [
        OutlinedButton(
          onPressed:
              (animation.status != AnimationStatus.forward) ? onPressed : null,
          child: child,
        ),
        if (animation.status == AnimationStatus.forward)
          Positioned.fill(
            bottom: 0,
            child: Material(
              color: Colors.transparent,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10),
                  bottomStart: Radius.circular(10),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: LinearProgressIndicator(
                value: animation.value,
                color: Colors.white12,
                backgroundColor: Colors.white.withOpacity(0),
              ),
            ),
          ),
      ],
    );
  }
}
