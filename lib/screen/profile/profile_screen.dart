// widgets/profile_header.dart
// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/config/screen_config.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/screen/auth/login_screen.dart';
import 'package:my_app/screen/event/llist_event_screen.dart';
import 'package:my_app/screen/profile/profile_widget/profile_button.dart';

import '../../logic/event/event_bloc.dart';
import 'profile_widget/logout_button.dart';
import 'profile_widget/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileHeader(username: "authModel.username"),
              const SizedBox(height: 24),
              // ProfileInfoCard(
              //   userId: " authModel.userId",
              //   username: " authModel.username",
              //   role: "authModel.role",
              // ),
              const SizedBox(height: 32),
              ProfileListTileButton(
                  leadingIcon: Icons.calendar_month,
                  title: "Events",
                  onTap: () {
                    context.read<EventBloc>().add(GetEvent());

                    pushScreen(context, AddRoundScreen());
                  }),
              ProfileListTileButton(
                  leadingIcon: Icons.group_add_outlined,
                  title: "Fighter",
                  onTap: () {
                    pushScreen(context, AddRoundScreen());
                  }),
              LogoutButton(
                onLogout: () {
                  SharedPrefsConfig.clearAll();
                  pushReplaceScreen(context, LoginScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
