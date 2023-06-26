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
      children: [
        ElevatedButton(
          onPressed:
              (animation.status != AnimationStatus.forward) ? onPressed : null,
          child: child,
        ),
        if (animation.status == AnimationStatus.forward)
          Positioned.fill(
            bottom: 0,
            child: LinearProgressIndicator(
              value: animation.value,
              color: Colors.black12,
              backgroundColor: Colors.black.withOpacity(0),
            ),
          ),
      ],
    );
  }
}
