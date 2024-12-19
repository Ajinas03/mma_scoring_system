part of 'navigation_bloc.dart';

final class NavigationInitial extends NavigationState {
  NavigationInitial() : super(currentScreen: 0);
}

class NavigationState {
  int currentScreen;

  NavigationState({required this.currentScreen});
}
