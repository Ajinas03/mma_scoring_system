part of 'auth_bloc.dart';

class AuthState {
  bool isLoading;

  AuthState({required this.isLoading});
}

final class AuthInitial extends AuthState {
  AuthInitial() : super(isLoading: true);
}
