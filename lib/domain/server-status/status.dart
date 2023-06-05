import 'announcement.dart';

class ServerStatus {
  final DateTime nextReset;
  final Iterable<Annoucement> annoucements;

  const ServerStatus({required this.nextReset, required this.annoucements});

  ServerStatus copyWith({
    DateTime? nextReset,
    Iterable<Annoucement>? annoucements,
  }) =>
      ServerStatus(
        nextReset: nextReset ?? this.nextReset,
        annoucements: annoucements ?? this.annoucements,
      );
}
