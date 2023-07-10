import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/domain/contract.dart';
import 'package:space_traders/infra-ui/components/countdown.dart';
import 'package:space_traders/infra-ui/components/future_button.dart';
import 'package:space_traders/infra-ui/components/pallette.dart';
import 'package:space_traders/infra-ui/components/section_header.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';

void showContractBottomModalSheet(BuildContext context, Contract contract) =>
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            color: lightWhite.withOpacity(0.1),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ContractDetail(contract: contract),
              ),
            ),
          ),
        );
      },
    );

class ContractDetail extends StatelessWidget {
  final Contract contract;
  const ContractDetail({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: contract.type.name),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text('Faction'), Text(contract.factionSymbol)],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('On accept'),
            Text(
              "+${contract.terms.payment.onAccepted}c",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: !contract.accepted ? green : null),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('On fullfill'),
            Text(
              "+${contract.terms.payment.onFulfilled}c",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: green),
            )
          ],
        ),
        if (!contract.accepted)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Deadline to accept'),
              Countdown(
                date: contract.deadlineToAccept!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: red),
              )
            ],
          ),
        if (contract.accepted)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Deadline'),
              Countdown(
                date: contract.terms.deadline,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: red),
              )
            ],
          ),
        const SectionHeader(title: "Delivery"),
        Expanded(
          child: ListView.builder(
            itemCount: contract.terms.deliver.length,
            itemBuilder: (context, index) => ListTile(
              leading:
                  Text(contract.terms.deliver[index].unitsRequired.toString()),
              title: Text(contract.terms.deliver[index].tradeSymbol),
              subtitle: Text(contract.terms.deliver[index].destinationSymbol),
            ),
          ),
        ),
        ButtonBar(
          children: [
            FutureButton(
              onPressed: () =>
                  Provider.of<AgentProvider>(context, listen: false)
                      .accept(contract)
                      .then(Navigator.of(context).pop),
              label: 'Accept',
            )
          ],
        )
      ],
    );
  }
}
