import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:space_traders/domain/contract.dart';
import 'package:space_traders/infra-ui/components/countdown.dart';
import 'package:space_traders/infra-ui/components/pallette.dart';
import 'package:space_traders/infra-ui/pages/home/contracts/contract_bottom_sheet.dart';

class ContractSummary extends StatelessWidget {
  final Contract contract;

  const ContractSummary({super.key, required this.contract});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: wrapper(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(contract.type.name),
              Text(
                "for the ${contract.factionSymbol} faction",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          subtitle: subtitle,
          onTap: () => showContractBottomModalSheet(context, contract),
        ),
      ),
    );
  }

  Widget wrapper({required Widget child}) => switch (contract.accepted) {
        true => Banner(
            message: 'Accepted',
            location: BannerLocation.bottomEnd,
            color: green.withOpacity(0.42),
            // textStyle: TextStyle(color: green, fontSize: 10),
            child: child,
          ),
        false => Container(child: child),
      };

  Widget get subtitle {
    final format = DateFormat.MMMMEEEEd();
    return switch (contract.accepted) {
      true => Countdown(date: contract.terms.deadline),
      false => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("accept before ${format.format(contract.deadlineToAccept!)}"),
          ],
        ),
    };
  }
}
