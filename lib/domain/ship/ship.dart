import 'package:space_traders/domain/ship/registration.dart';

import '../navigation/nav.dart';
import 'cargo.dart';

class Ship {
    final String symbol;
    final Nav nav;
    // final Crew crew;
    // final Fuel fuel;
    // final Frame frame;
    // final Reactor reactor;
    // final Engine engine;
    // final List<Module> modules;
    // final List<Mount> mounts;
    final ShipRegistration registration;
    final Cargo cargo;

    Ship({
        required this.symbol,
        required this.nav,
        // required this.crew,
        // required this.fuel,
        // required this.frame,
        // required this.reactor,
        // required this.engine,
        // required this.modules,
        // required this.mounts,
        required this.registration,
        required this.cargo,
    });

    factory Ship.fromJson(Map<String, dynamic> json) => Ship(
        symbol: json["symbol"],
        nav: Nav.fromJson(json["nav"]),
        // crew: Crew.fromJson(json["crew"]),
        // fuel: Fuel.fromJson(json["fuel"]),
        // frame: Frame.fromJson(json["frame"]),
        // reactor: Reactor.fromJson(json["reactor"]),
        // engine: Engine.fromJson(json["engine"]),
        // modules: List<Module>.from(json["modules"].map((x) => Module.fromJson(x))),
        // mounts: List<Mount>.from(json["mounts"].map((x) => Mount.fromJson(x))),
        registration: ShipRegistration.fromJson(json["registration"]),
        cargo: Cargo.fromJson(json["cargo"]),
    );

    Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "nav": nav.toJson(),
        // "crew": crew.toJson(),
        // "fuel": fuel.toJson(),
        // "frame": frame.toJson(),
        // "reactor": reactor.toJson(),
        // "engine": engine.toJson(),
        // "modules": List<dynamic>.from(modules.map((x) => x.toJson())),
        // "mounts": List<dynamic>.from(mounts.map((x) => x.toJson())),
        "registration": registration.toJson(),
        "cargo": cargo.toJson(),
    };
}