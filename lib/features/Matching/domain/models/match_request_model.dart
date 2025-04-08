enum UserRole { client, provider }

class MatchRequestModel {
  final String matchId;
  final String requesterId; // User who sent the request
  final String requestedId; // User who received the request
  final String status; // "pending", "accepted", "declined", "cancelled"
  final String senderId;
  final String receiverId;
  final String postId;
  final DateTime requestDate;
  final DateTime? acceptedDate;
  final DateTime? declinedDate;
  final DateTime? cancelledDate;
  final UserRole requesterRole;

  MatchRequestModel({
    required this.matchId,
    required this.requesterId,
    required this.requestedId,
    required this.status,
    required this.senderId,
    required this.receiverId,
    required this.postId,
    required this.requestDate,
    this.acceptedDate,
    this.declinedDate,
    this.cancelledDate,
    required this.requesterRole,
  });

  MatchRequestModel copyWith({
    String? matchId,
    String? requesterId,
    String? requestedId,
    String? status,
    String? senderId,
    String? receiverId,
    String? postId,
    DateTime? requestDate,
    DateTime? acceptedDate,
    DateTime? declinedDate,
    DateTime? cancelledDate,
    UserRole? requesterRole,
  }) {
    return MatchRequestModel(
      matchId: matchId ?? this.matchId,
      requesterId: requesterId ?? this.requesterId,
      requestedId: requestedId ?? this.requestedId,
      status: status ?? this.status,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      postId: postId ?? this.postId,
      requestDate: requestDate ?? this.requestDate,
      acceptedDate: acceptedDate ?? this.acceptedDate,
      declinedDate: declinedDate ?? this.declinedDate,
      cancelledDate: cancelledDate ?? this.cancelledDate,
      requesterRole: requesterRole ?? this.requesterRole,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matchId': matchId,
      'requesterId': requesterId,
      'requestedId': requestedId,
      'status': status,
      'senderId': senderId,
      'receiverId': receiverId,
      'postId': postId,
      'requestDate': requestDate.toIso8601String(),
      'acceptedDate': acceptedDate?.toIso8601String(),
      'declinedDate': declinedDate?.toIso8601String(),
      'cancelledDate': cancelledDate?.toIso8601String(),
      'requesterRole': requesterRole == UserRole.client ? "client" : "provider",
    };
  }

  factory MatchRequestModel.fromFireStore(Map<String, dynamic> data) {
    return MatchRequestModel(
      matchId: data['matchId'],
      requesterId: data['requesterId'],
      requestedId: data['requestedId'],
      status: data['status'],
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      postId: data['postId'],
      requestDate: DateTime.parse(data['requestDate']),
      acceptedDate: data['acceptedDate'] != null
          ? DateTime.parse(data['acceptedDate'])
          : null,
      declinedDate: data['declinedDate'] != null
          ? DateTime.parse(data['declinedDate'])
          : null,
      cancelledDate: data['cancelledDate'] != null
          ? DateTime.parse(data['cancelledDate'])
          : null,
      requesterRole: data['requesterRole'] == "client"
          ? UserRole.client
          : UserRole.provider,
    );
  }
}
