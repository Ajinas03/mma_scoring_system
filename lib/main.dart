import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/screen/auth/login_screen.dart';

import 'config/constants/colors.dart';
import 'logic/navigation_bloc/navigation_bloc.dart';
import 'logic/socket/socket_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NavigationBloc()),
          BlocProvider(create: (context) => SocketBloc())
        ],
        child: MaterialApp(
            title: 'MMA Scoring',
            theme: ThemeData(
              primaryColor: AppColors.primary,
              scaffoldBackgroundColor: AppColors.background,
            ),
            home: const LoginScreen()

            // const MainScreen(
            //   loginModel: null,
            // ),
            ));
  }
}
