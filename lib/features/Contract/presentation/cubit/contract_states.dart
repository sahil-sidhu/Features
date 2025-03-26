import 'package:chambas/features/Contract/domain/models/contract_model.dart';

abstract class ContractState {}

class ContractInitial extends ContractState {}

class ContractLoading extends ContractState {}

class ContractLoaded extends ContractState {
  final List<ContractModel> contracts;
  ContractLoaded(this.contracts);
}

class SingleContractLoaded extends ContractState {
  final ContractModel contract;
  SingleContractLoaded(this.contract);
}

class ContractEmpty extends ContractState {}

class ContractError extends ContractState {
  final String message;
  ContractError(this.message);
}

class ContractCreated extends ContractState {
  final ContractModel contract;
  ContractCreated(this.contract);
}

class ContractProposed extends ContractState {
  final ContractModel contract;
  ContractProposed(this.contract);
}

class ContractAccepted extends ContractState {
  final String contractId;
  ContractAccepted(this.contractId);
}

class ContractDeclined extends ContractState {
  final String contractId;
  ContractDeclined(this.contractId);
}

class ContractCanceled extends ContractState {
  final String contractId;
  ContractCanceled(this.contractId);
}

class ContractUpdated extends ContractState {
  final ContractModel contract;
  ContractUpdated(this.contract);
}

class ContractNegotiated extends ContractState {
  final ContractModel contract;
  ContractNegotiated(this.contract);
}

class ContractCompleted extends ContractState {
  final String contractId;
  ContractCompleted(this.contractId);
}

class ContractDeleted extends ContractState {
  final String contractId;
  ContractDeleted(this.contractId);
}
