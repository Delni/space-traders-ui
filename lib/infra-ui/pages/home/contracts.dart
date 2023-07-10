import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_traders/infra-ui/components/section_header.dart';
import 'package:space_traders/infra-ui/providers/agent.provider.dart';

import 'contracts/contract_summary.dart';

class Contracts extends StatelessWidget {
  const Contracts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AgentProvider>(builder: (ctx, provider, __) {
      if (!provider.initialized) {
        provider.loadContracts();
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: "Your contracts"),
          if (!provider.initialized) const LinearProgressIndicator(),
          ...provider.contracts
              .take(5)
              .map((contract) => ContractSummary(contract: contract))
        ],
      );
    });
  }
}
