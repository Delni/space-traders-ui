import 'package:flutter/material.dart';
import 'package:space_traders/infra-ui/pages/login/login_field.dart';
import 'package:space_traders/infra-ui/pages/login/sign_up.dart';

import 'annoucements/announcements.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 75.0),
                    child: Text(
                      "Space Traders",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: MediaQuery.of(context).size.width / 6),
                    ),
                  ),
                ),
                const LoginField(),
                const SignUp(),
              ],
            ),
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
