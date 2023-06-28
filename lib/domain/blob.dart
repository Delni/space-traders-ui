import 'ship/frame/engine_requirements.dart';

class Engine {
    final String symbol;
    final String name;
    final String description;
    final int condition;
    final int speed;
  final EngineRequirements requirements;

    Engine({
        required this.symbol,
        required this.name,
        required this.description,
        required this.condition,
        required this.speed,
        required this.requirements,
    });

    factory Engine.fromJson(Map<String, dynamic> json) => Engine(
        symbol: json["symbol"],
        name: json["name"],
        description: json["description"],
        condition: json["condition"],
        speed: json["speed"],
        requirements: EngineRequirements.fromJson(json["requirements"]),
    );

    Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "name": name,
        "description": description,
        "condition": condition,
        "speed": speed,
        "requirements": requirements.toJson(),
    };
}

class Module {
    final String symbol;
    final String name;
    final String description;
    final int? capacity;
    final ModuleRequirements requirements;
    final int? range;

    Module({
        required this.symbol,
        required this.name,
        required this.description,
        this.capacity,
        required this.requirements,
        this.range,
    });

    factory Module.fromJson(Map<String, dynamic> json) => Module(
        symbol: json["symbol"],
        name: json["name"],
        description: json["description"],
        capacity: json["capacity"],
        requirements: ModuleRequirements.fromJson(json["requirements"]),
        range: json["range"],
    );

    Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "name": name,
        "description": description,
        "capacity": capacity,
        "requirements": requirements.toJson(),
        "range": range,
    };
}

class ModuleRequirements {
    final int crew;
    final int power;
    final int slots;

    ModuleRequirements({
        required this.crew,
        required this.power,
        required this.slots,
    });

    factory ModuleRequirements.fromJson(Map<String, dynamic> json) => ModuleRequirements(
        crew: json["crew"],
        power: json["power"],
        slots: json["slots"],
    );

    Map<String, dynamic> toJson() => {
        "crew": crew,
        "power": power,
        "slots": slots,
    };
}

class Mount {
    final String symbol;
    final String name;
    final String description;
    final int strength;
  final EngineRequirements requirements;
    final List<String>? deposits;

    Mount({
        required this.symbol,
        required this.name,
        required this.description,
        required this.strength,
        required this.requirements,
        this.deposits,
    });

    factory Mount.fromJson(Map<String, dynamic> json) => Mount(
        symbol: json["symbol"],
        name: json["name"],
        description: json["description"],
        strength: json["strength"],
        requirements: EngineRequirements.fromJson(json["requirements"]),
        deposits: json["deposits"] == null ? [] : List<String>.from(json["deposits"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "name": name,
        "description": description,
        "strength": strength,
        "requirements": requirements.toJson(),
        "deposits": deposits == null ? [] : List<dynamic>.from(deposits!.map((x) => x)),
    };
}

class Reactor {
    final String symbol;
    final String name;
    final String description;
    final int condition;
    final int powerOutput;
    final ReactorRequirements requirements;

    Reactor({
        required this.symbol,
        required this.name,
        required this.description,
        required this.condition,
        required this.powerOutput,
        required this.requirements,
    });

    factory Reactor.fromJson(Map<String, dynamic> json) => Reactor(
        symbol: json["symbol"],
        name: json["name"],
        description: json["description"],
        condition: json["condition"],
        powerOutput: json["powerOutput"],
        requirements: ReactorRequirements.fromJson(json["requirements"]),
    );

    Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "name": name,
        "description": description,
        "condition": condition,
        "powerOutput": powerOutput,
        "requirements": requirements.toJson(),
    };
}

class ReactorRequirements {
    final int crew;

    ReactorRequirements({
        required this.crew,
    });

    factory ReactorRequirements.fromJson(Map<String, dynamic> json) => ReactorRequirements(
        crew: json["crew"],
    );

    Map<String, dynamic> toJson() => {
        "crew": crew,
    };
}