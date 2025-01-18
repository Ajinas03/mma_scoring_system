part of 'auth_bloc.dart';

class AuthState {
  bool isLoading;
  String? errorMessge;

  AuthState({required this.isLoading, this.errorMessge});
}

final class AuthInitial extends AuthState {
  AuthInitial()
      : super(
          isLoading: false,
        );
}
