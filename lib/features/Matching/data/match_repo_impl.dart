import 'package:chambas/features/Matching/domain/models/match_request_model.dart';
import 'package:chambas/features/Matching/domain/repository/match_repo_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatchRepoImpl implements MatchRepoInterface {
  final CollectionReference _matchesCollection =
      FirebaseFirestore.instance.collection('matches');

  final CollectionReference _profilesCollection =
      FirebaseFirestore.instance.collection("profiles");

  @override
  Future<MatchRequestModel> requestMatch(
      String requesterId, String requestedId, String requesterRole) async {
    try {
      final matchDocRef =
          FirebaseFirestore.instance.collection('matches').doc();

      MatchRequestModel matchRequest = MatchRequestModel(
        matchId: matchDocRef.id,
        requesterId: requesterId,
        requestedId: requestedId,
        status: 'pending',
        requestDate: DateTime.now(),
        requesterRole:
            requesterRole == "client" ? UserRole.client : UserRole.provider,
      );

      await matchDocRef.set(matchRequest.toJson());

      return matchRequest;
    } catch (e) {
      throw Exception("Failed to request match: $e");
    }
  }

  @override
  Future<void> acceptMatch(String matchId, String receiverId) async {
    try {
      DocumentReference matchRef = _matchesCollection.doc(matchId);
      DocumentSnapshot matchSnapshot = await matchRef.get();

      if (!matchSnapshot.exists) {
        throw Exception("Match not found");
      }

      // Update match status
      await matchRef.update({
        "status": "accepted",
        "acceptedDate": DateTime.now(),
      });

      // Fetch match details
      Map<String, dynamic> matchData =
          matchSnapshot.data() as Map<String, dynamic>;
      String requesterId = matchData["requesterId"];

      // Update both users' profiles with the matchId
      await _profilesCollection.doc(receiverId).update({
        "matches": FieldValue.arrayUnion([matchId])
      });

      await _profilesCollection.doc(requesterId).update({
        "matches": FieldValue.arrayUnion([matchId])
      });
    } catch (e) {
      throw Exception("Error accepting match: $e");
    }
  }

  @override
  Future<void> declineMatch(String matchId, String receiverId) async {
    try {
      DocumentReference matchRef = _matchesCollection.doc(matchId);

      await matchRef.update({
        "status": "declined",
        "declinedDate": DateTime.now(),
      });

      // No need to update profile since the match was declined
    } catch (e) {
      throw Exception("Error declining match: $e");
    }
  }

  @override
  Future<void> cancelMatch(String matchId, String requesterId) async {
    try {
      DocumentReference matchRef = _matchesCollection.doc(matchId);

      await matchRef.update({
        "status": "cancelled",
        "cancelledDate": DateTime.now(),
      });
    } catch (e) {
      throw Exception("Error cancelling match: $e");
    }
  }

  @override
  Future<void> deleteMatch(String matchId) async {
    try {
      await _matchesCollection.doc(matchId).delete();
    } catch (e) {
      throw Exception("Error deleting match: $e");
    }
  }

  @override
  Future<MatchRequestModel> updateMatch(
      String matchId, String newStatus) async {
    try {
      DocumentReference matchRef = _matchesCollection.doc(matchId);

      await matchRef.update({
        "status": newStatus,
        "acceptedDate": newStatus == "accepted" ? DateTime.now() : null,
        "declinedDate": newStatus == "declined" ? DateTime.now() : null,
        "cancelledDate": newStatus == "cancelled" ? DateTime.now() : null,
      });

      // Get updated match
      DocumentSnapshot updatedMatch = await matchRef.get();
      return MatchRequestModel.fromFireStore(
          updatedMatch.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception("Error updating match: $e");
    }
  }

  @override
  Future<MatchRequestModel?> getMatch(String matchId) async {
    try {
      var doc = await _matchesCollection.doc(matchId).get();

      if (doc.exists) {
        return MatchRequestModel.fromFireStore(
            doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error fetching match: $e");
    }
  }

  @override
  Future<List<MatchRequestModel>> getIncomingMatches(String userId) async {
    try {
      var querySnapshot = await _matchesCollection
          .where("requestedId", isEqualTo: userId)
          .get();

      return querySnapshot.docs.map((doc) {
        return MatchRequestModel.fromFireStore(
            doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching incoming matches: $e");
    }
  }

  @override
  Future<List<MatchRequestModel>> getSentMatches(String userId) async {
    try {
      var querySnapshot = await _matchesCollection
          .where("requesterId", isEqualTo: userId)
          .get();

      return querySnapshot.docs.map((doc) {
        return MatchRequestModel.fromFireStore(
            doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching sent matches: $e");
    }
  }
}
