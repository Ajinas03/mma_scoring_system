import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mma_scoring_system/logic/navigation_bloc/navigation_bloc.dart';
import 'package:mma_scoring_system/screen/event/event_screen.dart';
import 'package:mma_scoring_system/screen/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items = [
    const BottomNavigationBarItem(icon: Icon(Icons.event), label: "Event"),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Profile",
    ),
  ];

  final screens = [const EventScreen(), const ProfileScreen()];

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
