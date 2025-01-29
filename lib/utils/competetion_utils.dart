import '../models/competetion_model.dart';

String? getUserPosition(
    CompetetionModel competition, String currentUserId, String userRole) {
  // If the user's role is 'jury', return 'mainJury'
  if (userRole == 'jury') {
    return 'mainJury';
  }

  // Checking each referee position to see if it matches the current user
  if (competition.cornerAReferee.id == currentUserId) {
    return 'CornerAReferee';
  } else if (competition.cornerBReferee.id == currentUserId) {
    return 'CornerBReferee';
  } else if (competition.cornerCReferee.id == currentUserId) {
    return 'CornerCReferee';
  }
  return null; // User not found as a referee
}
