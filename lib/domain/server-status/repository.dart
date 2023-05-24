import 'announcement.dart';

abstract class ServerRepository {
  Future<Iterable<Annoucement>> getStatus();
}
