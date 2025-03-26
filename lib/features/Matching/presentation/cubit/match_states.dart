import 'package:chambas/features/Matching/domain/models/match_request_model.dart';

// Base abstract class for all states
abstract class MatchState {}

// Initial state
class MatchInitial extends MatchState {}

// Loading state
class MatchLoading extends MatchState {}

// When matches are successfully loaded
class MatchesLoaded extends MatchState {
  final List<MatchRequestModel> matches;
  MatchesLoaded(this.matches);
}

class SingleMatchLoaded extends MatchState {
  final MatchRequestModel match;
  SingleMatchLoaded(this.match);
}

// When no matches are found
class MatchEmpty extends MatchState {}

// Error state
class MatchError extends MatchState {
  final String message;
  MatchError(this.message);
}

// When a match request is successfully created
class MatchCreated extends MatchState {
  final MatchRequestModel match;
  MatchCreated(this.match);
}

// Match requested
class MatchRequested extends MatchState {
  final MatchRequestModel match;
  MatchRequested(this.match);
}

// When a match request is accepted
class MatchAccepted extends MatchState {
  final String matchId;
  MatchAccepted(this.matchId);
}

// When a match request is accepted
class MatchDeclined extends MatchState {
  final String matchId;
  MatchDeclined(this.matchId);
}

// When a match request is accepted
class MatchCanceled extends MatchState {
  final String matchId;
  MatchCanceled(this.matchId);
}

// When a match request is updated (declined/canceled)
class MatchUpdated extends MatchState {
  final MatchRequestModel match;
  MatchUpdated(this.match);
}

// When a match request is deleted
class MatchDeleted extends MatchState {
  final String matchId;
  MatchDeleted(this.matchId);
}
