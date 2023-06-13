import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/infra-ui/adapters.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';

class LoginField extends StatefulWidget {
  const LoginField({super.key});

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  final TextEditingController controller = TextEditingController();
  String? errorMessage;

  void saveTokenAndConnect(BuildContext context) {
    Adapters.saveTokenAdapter(controller.text);
    Provider.of<AgentProvider>(context, listen: false)
        .getMe()
        .then((value) => Navigator.of(context).pushReplacementNamed("/home"))
        .catchError((error) {
      setState(() {
        errorMessage = error;
      });
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: max(400, MediaQuery.of(context).size.width / 2),
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter your token to connect",
                errorText: errorMessage,
              ),
              controller: controller,
              textInputAction: TextInputAction.done,
              onChanged: (_) => setState(() {
                errorMessage = null;
              }),
              onSubmitted: (_) => saveTokenAndConnect(context),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            height: 42,
            child: AspectRatio(
              aspectRatio: 1,
              child: Tooltip(
                message: "Log in",
                child: ElevatedButton(
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                  ),
                  onPressed: () => saveTokenAndConnect(context),
                  child: const Icon(Icons.rocket_launch),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
