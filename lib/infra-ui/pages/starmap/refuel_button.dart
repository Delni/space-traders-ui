import 'package:flutter/material.dart';
import 'package:space_traders/domain/market/trade_good.dart';
import 'package:space_traders/infra-ui/components/future_button.dart';

class RefuelButton extends StatelessWidget {
  final List<TradeGood> tradeGoods;
  final int unitToResplenish;
  final Future Function() onRefuel;

  const RefuelButton({
    super.key,
    required this.tradeGoods,
    required this.unitToResplenish,
    required this.onRefuel,
  });

  @override
  Widget build(BuildContext context) {
    TradeGood? fuel =
        tradeGoods.where((good) => good.symbol == 'FUEL').firstOrNull;

    int? price = fuel != null ? fuel.purchasePrice * unitToResplenish : null;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: FutureButton(
        onPressed: fuel != null && unitToResplenish > 0 ? onRefuel : null,
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Refuel (${price ?? '-'}c)')),
      ),
    );
  }
}
