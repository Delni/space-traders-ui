import 'status.dart';


abstract class ServerRepository {
  Future<ServerStatus> getStatus();
}
