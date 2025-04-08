import 'package:chambas/features/Matching/domain/models/match_request_model.dart';

abstract class MatchRepoInterface {
  // Request a match
  Future<MatchRequestModel> requestMatch(String requesterId, String requestedId,
      String senderId, String receiverId, String postId, String requesterRole);

  // Accept a match (receiver accepts the request)
  Future<void> acceptMatch(String matchId, String receiverId);

  // Declines a match request (receiver declines instead of deleting)
  Future<void> declineMatch(String matchId, String receiverId);

  // Cancels a match request (sender cancels before acceptance)
  Future<void> cancelMatch(String matchId, String requesterId);

  // Deletes a match request (if necessary, e.g., admin removal)
  Future<void> deleteMatch(String matchId);

  // Updates a match request (used for changing status, like "pending" → "declined")
  Future<MatchRequestModel> updateMatch(String matchId, String newStatus);

  // Fetches a single match request by ID
  Future<MatchRequestModel?> getMatch(String matchId);

  // Fetches all incoming match requests for a user
  Future<List<MatchRequestModel>> getIncomingMatches(String userId);

  // Fetches all sent match requests by a user
  Future<List<MatchRequestModel>> getSentMatches(String userId);
}
