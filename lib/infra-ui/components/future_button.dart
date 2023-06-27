import 'package:flutter/material.dart';

class FutureButton extends StatefulWidget {
  final Future Function() onPressed;
  final String label;

  const FutureButton({super.key, required this.onPressed, required this.label});

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
      onPressed: () async {
        startLoading();
        await widget.onPressed();
        stopLoading();
      },
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
          : Text(widget.label),
    );
  }
}
