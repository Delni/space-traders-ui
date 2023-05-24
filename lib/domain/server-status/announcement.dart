
class Annoucement {
  final String title;
  final String body;

  Annoucement({required this.title, required this.body});
  factory Annoucement.fromJson(Map<String, dynamic> json) => Annoucement(
        title: json["title"],
        body: json["body"],
      );
}
