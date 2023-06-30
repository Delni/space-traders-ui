import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  const SectionHeader({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          if (actions != null) ...actions!
        ],
      ),
    );
  }
}
