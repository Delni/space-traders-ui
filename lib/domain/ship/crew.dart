class Crew {
  final int current;
  final int capacity;
  final int required;
  final String rotation;
  final int morale;
  final int wages;

  Crew({
    required this.current,
    required this.capacity,
    required this.required,
    required this.rotation,
    required this.morale,
    required this.wages,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        current: json["current"],
        capacity: json["capacity"],
        required: json["required"],
        rotation: json["rotation"],
        morale: json["morale"],
        wages: json["wages"],
      );

  Map<String, dynamic> toJson() => {
        "current": current,
        "capacity": capacity,
        "required": required,
        "rotation": rotation,
        "morale": morale,
        "wages": wages,
      };
}
