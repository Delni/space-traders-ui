import 'package:space_traders/domain/entity.dart';

import '../navigation/ship_nav.dart';
import 'registration.dart';
import 'ship_status.dart';
import 'cargo/cargo.dart';
import 'crew.dart';
import 'frame/frame.dart';
import 'fuel.dart';

class Ship extends Entity {
  final ShipNav nav;
  final Crew crew;
  final Fuel fuel;
  final ShipFrame frame;
  // final Reactor reactor;
  // final Engine engine;
  // final List<Module> modules;
  // final List<Mount> mounts;
  final ShipRegistration registration;
  final Cargo cargo;

  Ship({
    required super.symbol,
    required this.nav,
    required this.crew,
    required this.fuel,
    required this.frame,
    // required this.reactor,
    // required this.engine,
    // required this.modules,
    // required this.mounts,
    required this.registration,
    required this.cargo,
  });

  factory Ship.fromJson(Map<String, dynamic> json) => Ship(
        symbol: json["symbol"],
        nav: ShipNav.fromJson(json["nav"]),
        crew: Crew.fromJson(json["crew"]),
        fuel: Fuel.fromJson(json["fuel"]),
        frame: ShipFrame.fromJson(json["frame"]),
        // reactor: Reactor.fromJson(json["reactor"]),
        // engine: Engine.fromJson(json["engine"]),
        // modules: List<Module>.from(json["modules"].map((x) => Module.fromJson(x))),
        // mounts: List<Mount>.from(json["mounts"].map((x) => Mount.fromJson(x))),
        registration: ShipRegistration.fromJson(json["registration"]),
        cargo: Cargo.fromJson(json["cargo"]),
      );

  bool get isDocked => nav.status == ShipStatus.docked;
  bool get inOrbit => nav.status == ShipStatus.inOrbit;
  bool get inTransit => nav.status == ShipStatus.inTransit;

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "nav": nav.toJson(),
        "crew": crew.toJson(),
        "fuel": fuel.toJson(),
        // "frame": frame.toJson(),
        // "reactor": reactor.toJson(),
        // "engine": engine.toJson(),
        // "modules": List<dynamic>.from(modules.map((x) => x.toJson())),
        // "mounts": List<dynamic>.from(mounts.map((x) => x.toJson())),
        "registration": registration.toJson(),
        "cargo": cargo.toJson(),
      };

  Ship copyWith({
    String? symbol,
    ShipNav? nav,
    Crew? crew,
    Fuel? fuel,
    ShipFrame? frame,
    //  Reactor? reactor,
    //  Engine? engine,
    //  List<Module>? modules,
    //  List<Mount>? mounts,
    ShipRegistration? registration,
    Cargo? cargo,
  }) =>
      Ship(
        symbol: symbol ?? this.symbol,
        nav: nav ?? this.nav,
        crew: crew ?? this.crew,
        frame: frame ?? this.frame,
        fuel: fuel ?? this.fuel,
        registration: registration ?? this.registration,
        cargo: cargo ?? this.cargo,
      );
}
