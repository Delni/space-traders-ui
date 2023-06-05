import 'package:flutter/material.dart';

import 'annoucements/announcements.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(child: Text("Space Traders")),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: TextButton(
                onPressed: () => showAnnouncementsModal(context),
                child: const Text("Announcements"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
