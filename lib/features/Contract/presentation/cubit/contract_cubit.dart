import 'package:chambas/features/Contract/domain/models/contract_model.dart';
import 'package:chambas/features/Contract/domain/repository/contract_repo_interface.dart';
import 'package:chambas/features/Contract/presentation/cubit/contract_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContractCubit extends Cubit<ContractState> {
  final ContractRepoInterface contractRepo;

  ContractCubit({required this.contractRepo}) : super(ContractInitial());

  // Create a contract
  Future<void> createContract(String requesterId, String requestedId) async {
    try {
      emit(ContractLoading());
      final contract =
          await contractRepo.createContract(requesterId, requestedId);
      emit(ContractCreated(contract));
    } catch (e) {
      emit(ContractError("Failed to create contract: $e"));
    }
  }

  // Propose a contract
  Future<void> proposeContract(ContractModel contract) async {
    try {
      emit(ContractLoading());
      final updatedContract = await contractRepo.proposeContract(contract);
      emit(ContractProposed(updatedContract));
    } catch (e) {
      emit(ContractError("Failed to propose contract: $e"));
    }
  }

  // Accept a contract
  Future<void> acceptContract(String contractId, String receiverId) async {
    try {
      emit(ContractLoading());
      await contractRepo.acceptContract(contractId, receiverId);
      emit(ContractAccepted(contractId));
    } catch (e) {
      emit(ContractError("$e"));
    }
  }

  // Decline a contract
  Future<void> declineContract(String contractId, String receiverId) async {
    try {
      emit(ContractLoading());
      await contractRepo.declineContract(contractId, receiverId);
      emit(ContractDeclined(contractId));
    } catch (e) {
      emit(ContractError("$e"));
    }
  }

  // Cancel a contract
  Future<void> cancelContract(String contractId, String requesterId) async {
    try {
      emit(ContractLoading());
      await contractRepo.cancelContract(contractId, requesterId);
      emit(ContractCanceled(contractId));
    } catch (e) {
      emit(ContractError("$e"));
    }
  }

  // Delete a contract
  Future<void> deleteContract(String contractId) async {
    try {
      emit(ContractLoading());
      await contractRepo.deleteContract(contractId);
      emit(ContractDeleted(contractId));
    } catch (e) {
      emit(ContractError("$e"));
    }
  }

  // Update a contract
  Future<void> updateContract(ContractModel updatedContract) async {
    try {
      emit(ContractLoading());
      final updated = await contractRepo.updateContract(updatedContract);
      emit(ContractUpdated(updated));
    } catch (e) {
      emit(ContractError("$e"));
    }
  }

  // Get a single contract
  Future<void> getContract(String contractId) async {
    try {
      emit(ContractLoading());
      final contract = await contractRepo.getContract(contractId);
      emit(SingleContractLoaded(contract!));
    } catch (e) {
      emit(ContractError("$e"));
    }
  }

  // Get all incoming contracts
  Future<void> getIncomingContracts(String userId) async {
    try {
      emit(ContractLoading());
      final contracts = await contractRepo.getIncomingContracts(userId);
      emit(ContractLoaded(contracts));
    } catch (e) {
      emit(ContractError("$e"));
    }
  }

  // Get all sent contracts
  Future<void> getSentContracts(String userId) async {
    try {
      emit(ContractLoading());
      final contracts = await contractRepo.getSentContracts(userId);
      emit(ContractLoaded(contracts));
    } catch (e) {
      emit(ContractError("$e"));
    }
  }

  // Negotiate a contract
  Future<void> negotiateContract(
      String contractId, Map<String, dynamic> updatedFields) async {
    try {
      emit(ContractLoading());
      final updatedContract =
          await contractRepo.negotiateContract(contractId, updatedFields);
      emit(ContractNegotiated(updatedContract));
    } catch (e) {
      emit(ContractError("$e"));
    }
  }
}
