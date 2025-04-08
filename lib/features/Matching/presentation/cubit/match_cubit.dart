import 'package:chambas/features/Matching/domain/repository/match_repo_interface.dart';
import 'package:chambas/features/Matching/presentation/cubit/match_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchCubit extends Cubit<MatchState> {
  final MatchRepoInterface matchRepo;

  MatchCubit({required this.matchRepo}) : super(MatchInitial());

  // Send request and refresh both sent/received matches
  Future<void> requestMatch(
    String requesterId,
    String requestedId,
    String senderId,
    String receiverId,
    String postId,
    String requesterRole,
  ) async {
    try {
      emit(MatchLoading());
      final matchRequest = await matchRepo.requestMatch(
        requesterId,
        requestedId,
        senderId,
        receiverId,
        postId,
        requesterRole,
      );

      // Refresh both sides after sending
      final sentMatches = await matchRepo.getSentMatches(senderId);
      final receivedMatches = await matchRepo.getIncomingMatches(receiverId);

      emit(MatchesLoaded([...sentMatches, ...receivedMatches]));
      emit(MatchRequested(matchRequest));
    } catch (e) {
      emit(MatchError("$e"));
    }
  }

  // Accept a match request
  Future<void> acceptMatch(String matchId, String receiverId) async {
    try {
      emit(MatchLoading());
      await matchRepo.acceptMatch(matchId, receiverId);
      emit(MatchAccepted(matchId));
    } catch (e) {
      emit(MatchError("$e"));
    }
  }

  // Decline a match request
  Future<void> declineMatch(String matchId, String receiverId) async {
    try {
      emit(MatchLoading());
      await matchRepo.declineMatch(matchId, receiverId);
      emit(MatchCanceled(matchId));
    } catch (e) {
      emit(MatchError("$e"));
    }
  }

  // Cancel a match request
  Future<void> cancelMatch(String matchId, String requesterId) async {
    try {
      emit(MatchLoading());
      await matchRepo.cancelMatch(matchId, requesterId);
      emit(MatchCanceled(matchId));
    } catch (e) {
      emit(MatchError("$e"));
    }
  }

  // Delete a match request
  Future<void> deleteMatch(String matchId) async {
    try {
      emit(MatchLoading());
      await matchRepo.deleteMatch(matchId);
      emit(MatchDeleted(matchId));
    } catch (e) {
      emit(MatchError("$e"));
    }
  }

  // Update a match request (generic status update)
  Future<void> updateMatch(String matchId, String newStatus) async {
    try {
      emit(MatchLoading());
      final updatedMatch = await matchRepo.updateMatch(matchId, newStatus);
      emit(MatchUpdated(updatedMatch));
    } catch (e) {
      emit(MatchError("$e"));
    }
  }

  // Get a single match request
  Future<void> getMatch(String matchId) async {
    try {
      emit(MatchLoading());
      final match = await matchRepo.getMatch(matchId);
      if (match != null) {
        emit(SingleMatchLoaded(match));
      } else {
        emit(MatchEmpty());
      }
    } catch (e) {
      emit(MatchError("$e"));
    }
  }

  // Get incoming match requests
  Future<void> getIncomingMatches(String userId) async {
    try {
      emit(MatchLoading());
      final matches = await matchRepo.getIncomingMatches(userId);
      emit(matches.isEmpty ? MatchEmpty() : MatchesLoaded(matches));
    } catch (e) {
      emit(MatchError("$e"));
    }
  }

  // Get sent match requests
  Future<void> getSentMatches(String userId) async {
    try {
      emit(MatchLoading());
      final matches = await matchRepo.getSentMatches(userId);
      if (matches.isEmpty) {
        emit(MatchEmpty());
      } else {
        emit(MatchesLoaded(matches));
      }
    } catch (e) {
      emit(MatchError("$e"));
    }
  }
}
