import 'package:flutter/material.dart';
import 'package:space_traders/domain/server-status/status.dart';

class AnnouncementList extends StatelessWidget {
  final AsyncSnapshot<ServerStatus> snapshot;

  const AnnouncementList({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              snapshot.data!.annoucements.elementAt(index).title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              snapshot.data!.annoucements.elementAt(index).body,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
      itemCount: snapshot.data?.annoucements.length ?? 0,
    );
  }
}
