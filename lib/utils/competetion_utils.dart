import 'package:my_app/models/connected_user_model.dart';

import '../models/competetion_model.dart' as comp;

String? getUserPosition(
    comp.CompetetionModel competition, String currentUserId, String userRole) {
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

bool areAnyTwoConnected({
  required CornerAReferee? mainJury,
  required CornerAReferee? cornerAReferee,
  required CornerAReferee? cornerBReferee,
  required CornerAReferee? cornerCReferee,
}) {
  int connectedCount = 0;

  if (mainJury?.isConnected ?? false) connectedCount++;
  if (cornerAReferee?.isConnected ?? false) connectedCount++;
  if (cornerBReferee?.isConnected ?? false) connectedCount++;
  if (cornerCReferee?.isConnected ?? false) connectedCount++;

  return connectedCount >= 2;
}

String timeAgo(int milliseconds) {
  // Get the current time
  DateTime currentTime = DateTime.now();

  // Convert milliseconds to a DateTime object
  DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(milliseconds);

  // Calculate the difference between the current time and the timestamp
  Duration difference = currentTime.difference(timestamp);

  // Determine the appropriate time unit
  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} second${difference.inSeconds == 1 ? '' : 's'} ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
  } else if (difference.inDays < 30) {
    return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
  } else if (difference.inDays < 365) {
    return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() == 1 ? '' : 's'} ago';
  } else {
    return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() == 1 ? '' : 's'} ago';
  }
}
