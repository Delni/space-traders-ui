import 'dart:math';

import 'package:flutter/material.dart';
import 'package:space_traders/infra-ui/adapters.dart';

class LoginField extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  LoginField({super.key});

  void saveToken() => Adapters.saveTokenAdapter(controller.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: max(400, MediaQuery.of(context).size.width / 2),
      height: 42,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Enter your token to connect",
              ),
              controller: controller,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) => saveToken(),
            ),
          ),
          const SizedBox(width: 12),
          AspectRatio(
            aspectRatio: 1,
            child: Tooltip(
              message: "Log in",
              child: ElevatedButton(
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                ),
                onPressed: saveToken,
                child: const Icon(Icons.rocket_launch),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
