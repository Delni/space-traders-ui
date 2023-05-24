import 'package:flutter/material.dart';
import 'package:space_traders/infra-ui/adapters.dart';

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

void showAnnouncementsModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text("Announcements"),
            Expanded(
              child: FutureBuilder(
                future: Adapters.serverAdapter.getStatus(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator.adaptive());
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data!.elementAt(index).title),
                          Text(snapshot.data!.elementAt(index).body, textAlign: TextAlign.justify,),
                        ],
                      ),
                    ),
                    itemCount: snapshot.data?.length ?? 0,
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
