import 'package:dio/dio.dart';
import 'package:space_traders/domain/server-status/announcement.dart';
import 'package:space_traders/domain/server-status/repository.dart';

class ServerHttpAdapter implements ServerRepository {
  ServerHttpAdapter();
  final Dio _client = Dio();

  @override
  Future<Iterable<Annoucement>> getStatus() => _client
      .get('https://api.spacetraders.io/v2')
      .then((value) =>
          List<Map<String, dynamic>>.from(value.data["announcements"]))
      .then((value) => value.map(Annoucement.fromJson));
}
