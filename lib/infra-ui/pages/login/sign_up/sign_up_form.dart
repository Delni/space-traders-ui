import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:space_traders/domain/faction.dart';
import 'package:space_traders/infra-ui/adapters.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final agentController = TextEditingController();
  String? token;
  bool isLoading = false;
  Faction faction = Faction.cosmic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: token != null ? getToken(context) : getForm(context),
      ),
    );
  }

  Widget getToken(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome to the galaxy, Agent ${agentController.text}"),
          const Text(
            "Here is your unique token. Store it in a safe place, this is the only thing we have to make sure of your identity",
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: 40,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: token),
                    readOnly: true,
                    textAlign: TextAlign.justify,
                    minLines: 5,
                    maxLines: 10,
                  ),
                ),
                IconButton(
                    tooltip: "Copy to clipboard",
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: token!));
                    },
                    icon: const Icon(Icons.copy))
              ],
            ),
          ),
          ElevatedButton(
            onPressed: Navigator.of(context).pop,
            child: const Text("Get back"),
          ),
        ],
      );

  Widget getForm(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: agentController,
            decoration: const InputDecoration(
              label: Text("Agent's name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DropdownButton(
              isExpanded: true,
              hint: const Text("Agent's faction"),
              value: faction,
              onChanged: (value) => setState(() {
                faction = value ?? faction;
              }),
              items: Faction.values
                  .map((faction) => DropdownMenuItem(
                        value: faction,
                        child: Text(faction.name.toUpperCase()),
                      ))
                  .toList(),
            ),
          ),
          // Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(42.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    Adapters.serverAdapter
                        .register(agentController.text, faction)
                        .then((value) => setState(() {
                              isLoading = false;
                              token = value;
                            }));
                  },
                  child: isLoading
                      ? const SizedBox(
                          height: 12,
                          width: 12,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text("Register"),
                )
              ],
            ),
          ),
        ],
      );
}
