// widgets/profile_header.dart
// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/config/screen_config.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/screen/auth/login_screen.dart';

import '../../logic/navigation_bloc/navigation_bloc.dart';
import 'profile_widget/logout_button.dart';
import 'profile_widget/profile_header.dart';
import 'profile_widget/profile_info_card.dart';

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
              ProfileHeader(
                  username: SharedPrefsConfig.getString(
                      SharedPrefsConfig.keyUserName)),
              const SizedBox(height: 24),
              ProfileInfoCard(
                userId:
                    SharedPrefsConfig.getString(SharedPrefsConfig.keyUserId),
                username:
                    SharedPrefsConfig.getString(SharedPrefsConfig.keyUserName),
                role:
                    SharedPrefsConfig.getString(SharedPrefsConfig.keyUserRole),
              ),
              const SizedBox(height: 32),
              LogoutButton(
                onLogout: () {
                  SharedPrefsConfig.clearAll();
                  context.read<NavigationBloc>().add(ChangeScreen(scrnNum: 0));
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
