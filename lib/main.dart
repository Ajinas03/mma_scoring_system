import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/logic/auth/auth_bloc.dart';
import 'package:my_app/logic/event/event_bloc.dart';
import 'package:my_app/screen/auth/login_screen.dart';
import 'package:my_app/screen/main/main_screen.dart';

import 'config/theme_config.dart';
import 'logic/navigation_bloc/navigation_bloc.dart';
import 'logic/socket/socket_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefsConfig.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NavigationBloc()),
          BlocProvider(create: (context) => SocketBloc()),
          BlocProvider(create: (context) => AuthBloc()),
          BlocProvider(create: (context) => EventBloc())
        ],
        child: MaterialApp(
            title: 'MMA Scoring',
            theme: AppTheme.lightTheme,

            // ThemeData(
            //   primaryColor: Colors.black,
            //   scaffoldBackgroundColor: Colors.white,

            //   //  AppColors.background,
            // ),
            home: SharedPrefsConfig.getBool(SharedPrefsConfig.keyIsLoggedIn)
                ? MainScreen()
                : const LoginScreen()));
  }
}
