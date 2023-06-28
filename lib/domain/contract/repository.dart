import 'package:space_traders/domain/ship.dart';

import 'contract.dart';

abstract class ContractRepository {
  Future<List<Contract>> getMyContracts();
  Future<Contract> get(Contract contract);
  Future<Contract> accept(Contract contract);
  Future<Contract> fullfill(Contract contract);
  Future<Contract> deliver({
    required Contract contract,
    required Ship from,
    required CargoItemSummary goods,
  });
}
