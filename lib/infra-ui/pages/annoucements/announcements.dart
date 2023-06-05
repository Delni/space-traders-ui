import 'package:flutter/material.dart';
import 'package:space_traders/infra-ui/adapters.dart';

import 'announcement_list.dart';
import 'next_reset_countdown.dart';

void showAnnouncementsModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => const Announcements(),
  );
}

class Announcements extends StatelessWidget {
  const Announcements({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: FutureBuilder(
        future: Adapters.serverAdapter.getStatus(),
        builder: (context, snapshot) {
          return Column(
            children: [
              Text(
                "Announcements",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              NextResetCountdown(snapshot: snapshot),
              Expanded(child: AnnouncementList(snapshot: snapshot))
            ],
          );
        },
      ),
    );
  }
}
