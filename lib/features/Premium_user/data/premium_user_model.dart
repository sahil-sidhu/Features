class PremiumUserModel {
  final String userId;
  final String subscriptionPlan;
  final DateTime expiryDate;

  PremiumUserModel({
    required this.userId,
    required this.subscriptionPlan,
    required this.expiryDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'subscriptionPlan': subscriptionPlan,
      'expiryDate': expiryDate.toIso8601String(),
    };
  }

  static PremiumUserModel fromMap(Map<String, dynamic> map) {
    return PremiumUserModel(
      userId: map['userId'],
      subscriptionPlan: map['subscriptionPlan'],
      expiryDate: DateTime.parse(map['expiryDate']),
    );
  }
}
