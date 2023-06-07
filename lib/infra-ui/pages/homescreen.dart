import 'package:flutter/material.dart';
import 'package:space_traders/infra-ui/pages/home/login.dart';

import 'annoucements/announcements.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Space Traders",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Login()
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * .025,
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
