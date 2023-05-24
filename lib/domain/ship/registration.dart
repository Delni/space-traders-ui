import 'role.dart';

class ShipRegistration {
    final String name;
    final String factionSymbol;
    final ShipRole role;

    ShipRegistration({
        required this.name,
        required this.factionSymbol,
        required this.role,
    });

    factory ShipRegistration.fromJson(Map<String, dynamic> json) => ShipRegistration(
        name: json["name"],
        factionSymbol: json["factionSymbol"],
        role: ShipRoleMapper.fromString(json["role"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "factionSymbol": factionSymbol,
        "role": role.name,
    };
}