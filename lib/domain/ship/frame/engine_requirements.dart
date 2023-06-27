class EngineRequirements {
  final int power;
  final int crew;

  EngineRequirements({
    required this.power,
    required this.crew,
  });

  factory EngineRequirements.fromJson(Map<String, dynamic> json) =>
      EngineRequirements(
        power: json["power"],
        crew: json["crew"],
      );

  Map<String, dynamic> toJson() => {
        "power": power,
        "crew": crew,
      };
}
