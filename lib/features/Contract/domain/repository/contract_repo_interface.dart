import 'package:chambas/features/Contract/domain/models/contract_model.dart';

abstract class ContractRepoInterface {
  // Creates a contract request between two users (sender -> receiver). This will be triggered when a user accepts a match request.
  Future<ContractModel> createContract(String requesterId, String requestedId);

  // Proposes a contract after editing fields (sender sends a request to the receiver)
  Future<ContractModel> proposeContract(ContractModel contract);

  // Accept a contract (receiver accepts the request)
  Future<void> acceptContract(String contractId, String receiverId);

  // Declines a contract request (receiver declines instead of deleting)
  Future<void> declineContract(String contractId, String receiverId);

  // Cancels a contract request (sender cancels before acceptance)
  Future<void> cancelContract(String contractId, String requesterId);

  // Deletes a contract request (if necessary, e.g., admin removal)
  Future<void> deleteContract(String contractId);

  // Updates a contract request (used for changing status, like "pending" → "declined") and other fields
  Future<ContractModel> updateContract(ContractModel updatedContract);

  // Fetches a single contract request by ID
  Future<ContractModel?> getContract(String contractId);

  // Fetches all incoming contract requests for a user
  Future<List<ContractModel>> getIncomingContracts(String userId);

  // Fetches all sent contract requests by a user
  Future<List<ContractModel>> getSentContracts(String userId);

  // Negotiate a contract by updating the fields
  Future<ContractModel> negotiateContract(
      String contractId, Map<String, dynamic> updatedFields);
}
