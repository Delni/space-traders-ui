import 'ship/engine_requirements.dart';

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

class Fuel {
    final int current;
    final int capacity;
    final Consumed consumed;

    Fuel({
        required this.current,
        required this.capacity,
        required this.consumed,
    });

    factory Fuel.fromJson(Map<String, dynamic> json) => Fuel(
        current: json["current"],
        capacity: json["capacity"],
        consumed: Consumed.fromJson(json["consumed"]),
    );

    Map<String, dynamic> toJson() => {
        "current": current,
        "capacity": capacity,
        "consumed": consumed.toJson(),
    };
}

class Consumed {
    final int amount;
    final DateTime timestamp;

    Consumed({
        required this.amount,
        required this.timestamp,
    });

    factory Consumed.fromJson(Map<String, dynamic> json) => Consumed(
        amount: json["amount"],
        timestamp: DateTime.parse(json["timestamp"]),
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "timestamp": timestamp.toIso8601String(),
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