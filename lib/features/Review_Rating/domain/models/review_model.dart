class ReviewModel {
  final String id;
  final String contractId;
  final String reviewerId;
  final String revieweeId;
  final int rating;
  final String? comment;
  final bool isAnonymous;
  final DateTime dateCreated;

  ReviewModel({
    required this.id,
    required this.contractId,
    required this.reviewerId,
    required this.revieweeId,
    required this.rating,
    this.comment,
    required this.isAnonymous,
    required this.dateCreated,
  });
}
