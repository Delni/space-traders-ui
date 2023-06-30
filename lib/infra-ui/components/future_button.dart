import 'package:flutter/material.dart';

class FutureButton extends StatefulWidget {
  final Future Function()? onPressed;
  final String? label;
  final Widget? child;
  final ButtonStyle? style;

  const FutureButton({
    super.key,
    required this.onPressed,
    this.label,
    this.child,
    this.style,
  }) : assert(label != null || child != null);

  @override
  State<FutureButton> createState() => _FutureButtonState();
}

class _FutureButtonState extends State<FutureButton> {
  bool loading = false;

  void startLoading() => setState(() {
        loading = true;
      });

  void stopLoading() => setState(() {
        loading = false;
      });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: widget.style,
      onPressed: widget.onPressed != null
          ? () async {
        startLoading();
              await widget.onPressed!();
        stopLoading();
            }
          : null,
      child: loading
          ? const SizedBox(
              height: 12,
              child: AspectRatio(
                aspectRatio: 1,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            )
          : widget.child ?? Text(widget.label!),
    );
  }
}
