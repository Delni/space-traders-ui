import 'package:space_traders/domain/market/supply.dart';

class TradeGood {
  final String symbol;
  final int tradeVolume;
  final Supply supply;
  final int purchasePrice;
  final int sellPrice;

  TradeGood({
    required this.symbol,
    required this.tradeVolume,
    required this.supply,
    required this.purchasePrice,
    required this.sellPrice,
  });

  factory TradeGood.fromJson(Map<String, dynamic> json) => TradeGood(
        symbol: json["symbol"],
        tradeVolume: json["tradeVolume"],
        supply: Supply.values
            .firstWhere((element) => element.name == json["supply"]),
        purchasePrice: json["purchasePrice"],
        sellPrice: json["sellPrice"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "tradeVolume": tradeVolume,
        "supply": supply.name,
        "purchasePrice": purchasePrice,
        "sellPrice": sellPrice,
      };
}
