import 'package:chambas/features/Matching/domain/models/match_request_model.dart';

enum ContractStatus { pending, accepted, inProgress, completed, cancelled }

class ContractModel extends MatchRequestModel {
  final String contractId;
  final ContractStatus contractStatus;
  final bool isCompleted;
  final bool requesterAgreement;
  final bool providerAgreement;
  final double price;
  final String contractLocation;
  final DateTime contractStartDate;
  final DateTime? contractEndDate;
  final DateTime? contractDeclinedDate;
  final DateTime? contractCancelledDate;

  ContractModel({
    required this.contractId,
    required this.contractStatus,
    required this.isCompleted,
    required this.price,
    required this.providerAgreement,
    required this.requesterAgreement,
    required this.contractStartDate,
    required this.contractLocation,
    required super.matchId,
    required super.requesterId,
    required super.requestedId,
    required super.status,
    required super.senderId,
    required super.receiverId,
    required super.postId,
    required super.requestDate,
    required super.requesterRole,
    this.contractDeclinedDate,
    this.contractCancelledDate,
    this.contractEndDate,
  });

  @override
  ContractModel copyWith({
    String? matchId,
    String? requesterId,
    String? requestedId,
    String? status,
    String? senderId,
    String? receiverId,
    String? postId,
    UserRole? requesterRole,
    DateTime? requestDate,
    DateTime? acceptedDate,
    DateTime? cancelledDate,
    DateTime? declinedDate,
    String? contractId,
    ContractStatus? contractStatus,
    bool? isCompleted,
    double? price,
    bool? providerAgreement,
    bool? requesterAgreement,
    DateTime? contractStartDate,
    DateTime? contractEndDate,
    String? contractLocation,
  }) {
    return ContractModel(
      matchId: matchId ?? this.matchId,
      requesterId: requesterId ?? this.requesterId,
      requestedId: requestedId ?? this.requestedId,
      status: status ?? this.status,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      postId: postId ?? this.postId,
      requesterRole: requesterRole ?? this.requesterRole,
      requestDate: requestDate ?? this.requestDate,
      contractId: contractId ?? this.contractId,
      contractStatus: contractStatus ?? this.contractStatus,
      isCompleted: isCompleted ?? this.isCompleted,
      price: price ?? this.price,
      providerAgreement: providerAgreement ?? this.providerAgreement,
      requesterAgreement: requesterAgreement ?? this.requesterAgreement,
      contractStartDate: contractStartDate ?? this.contractStartDate,
      contractEndDate: contractEndDate ?? this.contractEndDate,
      contractLocation: contractLocation ?? this.contractLocation,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'matchId': matchId,
      'requesterId': requesterId,
      'requestedId': requestedId,
      'status': status, // Match status
      'senderId': senderId,
      'receiverId': receiverId,
      'postId': postId,
      'requestDate': requestDate.toIso8601String(),
      // Remove acceptedDate if it's not part of the model
      'contractId': contractId,
      'contractStatus':
          contractStatus.toString().split('.').last, // Converts enum to string
      'isCompleted': isCompleted,
      'requesterAgreement': requesterAgreement,
      'providerAgreement': providerAgreement,
      'price': price,
      'contractStartDate': contractStartDate.toIso8601String(),
      'contractEndDate': contractEndDate?.toIso8601String(),
      'contractLocation': contractLocation,
      'requesterRole':
          requesterRole.toString().split('.').last, // Add role to json
      "contractDeclinedDate": contractDeclinedDate?.toIso8601String(),
      "contractCancelledDate": contractCancelledDate?.toIso8601String(),
    };
  }

  @override
  factory ContractModel.fromFireStore(Map<String, dynamic> data) {
    return ContractModel(
      matchId: data['matchId'],
      requesterId: data['requesterId'],
      requestedId: data['requestedId'],
      status: data['status'],
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      postId: data['postId'],
      requestDate: DateTime.parse(data['requestDate']),

      contractId: data['contractId'],
      contractStatus: ContractStatus.values.firstWhere(
          (e) => e.toString().split('.').last == data['contractStatus']),
      isCompleted: data['isCompleted'],
      requesterAgreement: data['requesterAgreement'],
      providerAgreement: data['providerAgreement'],
      price: data['price'],
      contractStartDate: DateTime.parse(data['contractStartDate']),
      contractEndDate: data['contractEndDate'] != null
          ? DateTime.parse(data['contractEndDate'])
          : null,
      contractLocation: data['contractLocation'],
      requesterRole: UserRole.values.firstWhere((e) =>
          e.toString().split('.').last ==
          data['requesterRole']), // Map to UserRole
      contractDeclinedDate: data['contractDeclinedDate'] != null
          ? DateTime.parse(data['contractDeclinedDate'])
          : null,
      contractCancelledDate: data['contractCancelledDate'] != null
          ? DateTime.parse(data['contractCancelledDate'])
          : null,
    );
  }
}
