import 'package:chambas/features/Contract/domain/models/contract_model.dart';
import 'package:chambas/features/Contract/domain/repository/contract_repo_interface.dart';
import 'package:chambas/features/Matching/domain/models/match_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContractRepoImpl implements ContractRepoInterface {
  final CollectionReference _contractsCollection =
      FirebaseFirestore.instance.collection('contracts');

  final CollectionReference _matchesCollection =
      FirebaseFirestore.instance.collection('matches');

  @override
  Future<ContractModel> createContract(
      String requesterId, String requestedId) async {
    try {
      // Generate a unique contractId
      String contractId = _contractsCollection.doc().id;

      // Create contract request
      ContractModel contract = ContractModel(
        matchId: _matchesCollection.doc().id,
        requesterId: requesterId,
        requestedId: requestedId,
        status: "pending",
        requestDate: DateTime.now(),
        contractId: contractId,
        contractStatus: ContractStatus.pending,
        isCompleted: false,
        requesterAgreement: false,
        providerAgreement: false,
        price: 0.0,
        contractStartDate: DateTime.now(),
        contractEndDate: null,
        contractLocation: "",
        requesterRole: UserRole.client,
      );

      // Save to Firestore
      await _contractsCollection.doc(contractId).set(contract.toJson());

      return contract;
    } catch (e) {
      throw Exception("Failed to create contract: $e");
    }
  }

  @override
  Future<ContractModel> proposeContract(ContractModel contract) async {
    try {
      await _contractsCollection
          .doc(contract.contractId)
          .set(contract.toJson());
      return contract;
    } catch (e) {
      throw Exception("Failed to propose contract: $e");
    }
  }

  @override
  Future<void> acceptContract(String contractId, String receiverId) async {
    try {
      await _contractsCollection.doc(contractId).update({
        'contractStatus': ContractStatus.accepted.toString(),
        'providerAgreement': true,
      });
    } catch (e) {
      throw Exception("Failed to accept contract: $e");
    }
  }

  @override
  Future<void> declineContract(String contractId, String receiverId) async {
    try {
      await _contractsCollection.doc(contractId).update({
        'contractStatus': ContractStatus.cancelled.toString(),
        'providerAgreement': false,
      });
    } catch (e) {
      throw Exception("Failed to decline contract: $e");
    }
  }

  @override
  Future<void> cancelContract(String contractId, String requesterId) async {
    try {
      await _contractsCollection.doc(contractId).update({
        'contractStatus': ContractStatus.cancelled.toString(),
        'requesterAgreement': false,
      });
    } catch (e) {
      throw Exception("Failed to cancel contract: $e");
    }
  }

  @override
  Future<void> deleteContract(String contractId) async {
    try {
      await _contractsCollection.doc(contractId).delete();
    } catch (e) {
      throw Exception("Failed to delete contract: $e");
    }
  }

  @override
  Future<ContractModel> updateContract(ContractModel updatedContract) async {
    try {
      await _contractsCollection
          .doc(updatedContract.contractId)
          .update(updatedContract.toJson());
      return updatedContract;
    } catch (e) {
      throw Exception("Failed to update contract: $e");
    }
  }

  @override
  Future<ContractModel?> getContract(String contractId) async {
    try {
      DocumentSnapshot doc = await _contractsCollection.doc(contractId).get();
      if (doc.exists) {
        return ContractModel.fromFireStore(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Failed to get contract: $e");
    }
  }

  @override
  Future<List<ContractModel>> getIncomingContracts(String userId) async {
    try {
      QuerySnapshot query = await _contractsCollection
          .where('requestedId', isEqualTo: userId)
          .get();
      return query.docs
          .map((doc) =>
              ContractModel.fromFireStore(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Failed to get incoming contracts: $e");
    }
  }

  @override
  Future<List<ContractModel>> getSentContracts(String userId) async {
    try {
      QuerySnapshot query = await _contractsCollection
          .where('requesterId', isEqualTo: userId)
          .get();
      return query.docs
          .map((doc) =>
              ContractModel.fromFireStore(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Failed to get sent contracts: $e");
    }
  }

  @override
  Future<ContractModel> negotiateContract(
      String contractId, Map<String, dynamic> updatedFields) async {
    try {
      await _contractsCollection.doc(contractId).update(updatedFields);
      DocumentSnapshot doc = await _contractsCollection.doc(contractId).get();
      return ContractModel.fromFireStore(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception("Failed to negotiate contract: $e");
    }
  }
}
