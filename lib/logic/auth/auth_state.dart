part of 'auth_bloc.dart';

class AuthState {
  bool isLoading;
  String? errorMessge;
  String? signUpError;

  AuthState({required this.isLoading, this.errorMessge, this.signUpError});
}

final class AuthInitial extends AuthState {
  AuthInitial()
      : super(
          isLoading: false,
        );
}
