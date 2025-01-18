part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  LoginEvent(
      {required this.password, required this.phoneNum, required this.context});
  BuildContext context;
  String phoneNum;
  String password;
}
