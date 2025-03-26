class BusinessAccountModel {
  final String businessId;
  final String businessName;
  final String ownerUserId;
  final List<String> jobListings;

  BusinessAccountModel({
    required this.businessId,
    required this.businessName,
    required this.ownerUserId,
    required this.jobListings,
  });

  Map<String, dynamic> toMap() {
    return {
      'businessId': businessId,
      'businessName': businessName,
      'ownerUserId': ownerUserId,
      'jobListings': jobListings,
    };
  }

  static BusinessAccountModel fromMap(Map<String, dynamic> map) {
    return BusinessAccountModel(
      businessId: map['businessId'],
      businessName: map['businessName'],
      ownerUserId: map['ownerUserId'],
      jobListings: List<String>.from(map['jobListings']),
    );
  }
}
