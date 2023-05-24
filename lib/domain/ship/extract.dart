import 'package:space_traders/domain/ship.dart';

class ExtractionResult {
    final Extraction extraction;
    final Cooldown cooldown;
    final Cargo cargo;

    ExtractionResult({
        required this.extraction,
        required this.cooldown,
        required this.cargo,
    });

    factory ExtractionResult.fromJson(Map<String, dynamic> json) => ExtractionResult(
        extraction: Extraction.fromJson(json["extraction"]),
        cooldown: Cooldown.fromJson(json["cooldown"]),
        cargo: Cargo.fromJson(json["cargo"]),
    );

    Map<String, dynamic> toJson() => {
        "extraction": extraction.toJson(),
        "cooldown": cooldown.toJson(),
        "cargo": cargo.toJson(),
    };
}

class Extraction {
    final String shipSymbol;
    final CargoItemSummary yield;

    Extraction({
        required this.shipSymbol,
        required this.yield,
    });

    factory Extraction.fromJson(Map<String, dynamic> json) => Extraction(
        shipSymbol: json["shipSymbol"],
        yield: CargoItemSummary.fromJson(json["yield"]),
    );

    Map<String, dynamic> toJson() => {
        "shipSymbol": shipSymbol,
        "yield": yield.toJson(),
    };
}