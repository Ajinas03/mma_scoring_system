part of 'auth_bloc.dart';

class AuthState {
  bool isLoading;
  String? errorMessge;
  String? signUpError;
  UserExistModel? userExistModel;

  AuthState(
      {required this.isLoading,
      this.errorMessge,
      this.signUpError,
      this.userExistModel});
}

final class AuthInitial extends AuthState {
  AuthInitial()
      : super(
          isLoading: false,
        );
}
