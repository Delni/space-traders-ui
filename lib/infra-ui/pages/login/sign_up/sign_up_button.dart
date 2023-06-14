import 'package:flutter/material.dart';
import 'package:space_traders/infra-ui/pages/login/sign_up/sign_up_modal_route.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).push(SignUpModalRoute()),
      child: const Text("No token? Create an account here"),
    );
  }
}
