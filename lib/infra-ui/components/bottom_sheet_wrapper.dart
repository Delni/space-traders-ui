import 'dart:ui';

import 'package:flutter/material.dart';

import 'pallette.dart';

class BottomSheetWrapper extends StatelessWidget {
  final Widget child;

  const BottomSheetWrapper({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: lightWhite.withOpacity(0.1),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
