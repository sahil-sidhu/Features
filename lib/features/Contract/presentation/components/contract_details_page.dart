import 'package:chambas/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:chambas/features/Contract/domain/models/contract_model.dart';
import 'package:chambas/features/Contract/presentation/cubit/contract_cubit.dart';
import 'package:chambas/features/Contract/presentation/cubit/contract_states.dart';
import 'package:chambas/features/Matching/domain/models/match_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContractDetailsPage extends StatelessWidget {
  final ContractModel contract;

  const ContractDetailsPage({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final contractCubit = context.read<ContractCubit>();
    final String currentUserId = authCubit.currentUser!.uid;

    final bool isRequester = contract.requesterId == currentUserId;
    final bool isClient = isRequester
        ? contract.requesterRole == UserRole.client
        : contract.requesterRole == UserRole.client;

    final bool isProvider = !isClient;

    return Scaffold(
      appBar: AppBar(
        title: Text("Contract Details"),
      ),
      body: BlocBuilder<ContractCubit, ContractState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfo("Client", contract.requesterId),
                _buildUserInfo("Provider", contract.requestedId),
                const SizedBox(height: 16),
                _buildContractFields(contract),
                const SizedBox(height: 16),
                _buildActionButtons(
                    context, contractCubit, contract, isClient, isProvider)
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _buildUserInfo(String label, String userId) {
  return Text("$label $userId",
      style: const TextStyle(fontWeight: FontWeight.bold));
}

Widget _buildContractFields(ContractModel contract) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Location: ${contract.contractLocation}"),
      Text("Amount: \$${contract.price}"),
      Text("Start Date: ${contract.contractStartDate}"),
      Text("End Date: ${contract.contractEndDate}"),
      Text("Status: ${contract.status.toUpperCase()}",
          style: const TextStyle(fontWeight: FontWeight.bold)),
    ],
  );
}

Widget _buildActionButtons(BuildContext context, ContractCubit contractCubit,
    ContractModel contract, bool isClient, bool isProvider) {
  List<Widget> buttons = [];

  switch (contract.status) {
    case ContractStatus.pending:
      if (isProvider) {
        buttons.addAll([
          _actionButton(
            "Accept",
            () => contractCubit.acceptContract(
                contract.contractId, contract.requestedId),
          ),
          _actionButton(
            "Propose Changes",
            () => contractCubit.proposeContract(contract),
          ),
          _actionButton(
            "Decline",
            () => contractCubit.cancelContract(
                contract.contractId, contract.requesterId),
          ),
        ]);
      }
      if (isClient) {
        buttons.add(
          _actionButton(
            "Cancel",
            () => contractCubit.cancelContract(
                contract.contractId, contract.requesterId),
          ),
        );
      }
      break;

    case ContractStatus.inProgress:
      if (isClient) {
        buttons.addAll(
          [
            _actionButton(
              "Accept",
              () => contractCubit.acceptContract(
                  contract.contractId, contract.requestedId),
            ),
            _actionButton("Propose Changes",
                () => contractCubit.proposeContract(contract)),
            _actionButton(
              "Decline",
              () => contractCubit.cancelContract(
                  contract.contractId, contract.requesterId),
            ),
          ],
        );
      }
      break;

// TODO Implement the rest of the contract status cases, I think I may need another state of "Completed" or check how to update the status of the contract to completed.
    case ContractStatus.accepted:
      if (isClient) {
        buttons.add(_actionButton(
          "Mark as Completed",
          () async {
            final updatedContract =
                await contractCubit.proposeContract(contract);
            // contractCubit.updateContract(updatedContract);
          },
        ));
      }
      break;

    case ContractStatus.completed:
      buttons.add(_actionButton(
          "Leave Review", () => print("Review Flow Not Implemented")));
      break;

    case ContractStatus.cancelled:
      buttons.add(const Text("This contract was cancelled."));
      break;
  }

  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: buttons);
}

Widget _actionButton(String label, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(label),
  );
}
