import 'package:space_traders/domain/faction.dart';
import 'package:space_traders/domain/server_status.dart';

class ServerInMemoryAdapter implements ServerRepository {
  @override
  Future<ServerStatus> getStatus() => Future.value(
        ServerStatus(
          nextReset: DateTime.parse("2023-06-05T16:00:00.000Z"),
          annoucements: [
            Annoucement(
              title: "Test Announcement",
              body: "Officia et est aliqua adipisicing.",
            )
          ],
        ),
      );

  @override
  Future<String> register(String agentName, Faction faction) =>
      Future.value("token");
}
