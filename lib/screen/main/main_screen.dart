import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/logic/navigation_bloc/navigation_bloc.dart';
import 'package:my_app/screen/home/home_screen.dart';
import 'package:my_app/screen/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final items = [
    const BottomNavigationBarItem(icon: Icon(Icons.event), label: "Event"),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Profile",
    ),
  ];

  List<dynamic> screens = [];

  @override
  void initState() {
    print(
        "${SharedPrefsConfig.getString(SharedPrefsConfig.keyAccessToken)}tokennnnnnn");
    screens = [
      const HomeScreen(),

      // RoundScreen(
      //   loginModel: widget.loginModel,
      // ),
      const ProfileScreen()
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
              onTap: (i) {
                context.read<NavigationBloc>().add(ChangeScreen(scrnNum: i));

                print("selected item = $i");
              },
              currentIndex: state.currentScreen,
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.red,
              items: items);
        },
      ),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, navState) {
          return screens[navState.currentScreen];
        },
      ),
    );
  }
}
