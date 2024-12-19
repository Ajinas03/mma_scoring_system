part of 'navigation_bloc.dart';

class ChangeScreen extends NavigationEvent {
  final int scrnNum;

  ChangeScreen({required this.scrnNum});
}

@immutable
abstract class NavigationEvent {}
