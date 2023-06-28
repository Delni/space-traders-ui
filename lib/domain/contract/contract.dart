import 'contract_type.dart';
import 'terms.dart';

class Contract {
  final String id;
  final String factionSymbol;
  final ContractType type;
  final Terms terms;
  final bool accepted;
  final bool fulfilled;
  final DateTime expiration;
  final DateTime? deadlineToAccept;

  Contract({
    required this.id,
    required this.factionSymbol,
    required this.type,
    required this.terms,
    required this.accepted,
    required this.fulfilled,
    required this.expiration,
    required this.deadlineToAccept,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        id: json["id"],
        factionSymbol: json["factionSymbol"],
        type: ContractType.values
            .firstWhere((element) => element.name == json["type"]),
        terms: Terms.fromJson(json["terms"]),
        accepted: json["accepted"],
        fulfilled: json["fulfilled"],
        expiration: DateTime.parse(json["expiration"]),
        deadlineToAccept: json["deadlineToAccept"] != null
            ? DateTime.parse(json["deadlineToAccept"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "factionSymbol": factionSymbol,
        "type": type.name,
        "terms": terms.toJson(),
        "accepted": accepted,
        "fulfilled": fulfilled,
        "expiration": expiration.toIso8601String(),
        "deadlineToAccept": deadlineToAccept?.toIso8601String(),
      };
}
