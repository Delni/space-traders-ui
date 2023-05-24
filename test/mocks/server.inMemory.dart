import 'package:space_traders/domain/server-status/announcement.dart';
import 'package:space_traders/domain/server-status/repository.dart';

class ServerInMemoryAdapter implements ServerRepository {
  @override
  Future<List<Annoucement>> getStatus() => Future.value([
        Annoucement(
          title: "Test Announcement",
          body: "Officia et est aliqua adipisicing.",
        )
      ]);
}
