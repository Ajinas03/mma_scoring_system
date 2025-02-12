import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/screen_config.dart';
import '../logic/auth/auth_bloc.dart';
import '../models/user_exist_model.dart';
import '../screen/add_data/create_participants_screen.dart.dart';

Future<void> checkUserAndNavigate(
    {required BuildContext context,
    required String phone,
    required String role,
    required String eventId,
    required UserExistModel? existingUser}) async {
  // Show loading indicator
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  try {
    // Check if user exists

    // Dismiss loading dialog
    Navigator.of(context, rootNavigator: true).pop();

    if (existingUser != null) {
      // User exists, show confirmation dialog
      final shouldUseExistingUser = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('User Already Exists'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${existingUser.fname} ${existingUser.lname}'),
              Text('Email: ${existingUser.email}'),
              Text('Phone: ${existingUser.phone}'),
              const SizedBox(height: 10),
              const Text('Do you want to use this user?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Create New'),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          context.read<AuthBloc>().add(
                                AddExistingParticipant(
                                  userId: existingUser.userId,
                                  eventId: eventId,
                                  phone: phone,
                                  fname: existingUser.fname,
                                  lname: existingUser.lname,
                                  role: role,
                                  context: context,
                                ),
                              );
                        },
                        child: const Text('Use Existing'),
                      );
              },
            ),
          ],
        ),
      );

      if (shouldUseExistingUser == true) {
        // TODO: Implement logic to use existing user
        // This might involve creating a participant with existing user details
        // For now, just print
        print(
            'Using existing user: ${existingUser.fname} ${existingUser.lname}');
        return;
      }
    }

    // Navigate to create participant screen
    pushScreen(
      context,
      CreateParticipantScreen(
        role: role,
        eventId: eventId,
      ),
    );
  } catch (e) {
    // Dismiss loading dialog
    Navigator.of(context, rootNavigator: true).pop();

    // Show error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error checking user: $e')),
    );

    // Fallback to create participant screen

    // Navigator.pop(context);

    pushScreen(
      context,
      CreateParticipantScreen(
        role: role,
        eventId: eventId,
      ),
    );
  }
}
