part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  LoginEvent(
      {required this.password, required this.phoneNum, required this.context});
  BuildContext context;
  String phoneNum;
  String password;
}

class SignupEvent extends AuthEvent {
  SignupEvent(
      {required this.fname,
      required this.lname,
      required this.email,
      required this.phone,
      required this.role,
      required this.password,
      required this.city,
      required this.state,
      required this.country,
      required this.zipcode,
      required this.context});

  final String fname;
  final String lname;
  final String email;
  final String phone;
  final String role;
  final String password;
  final String city;
  final String state;
  final String country;
  final String zipcode;
  BuildContext context;
}

class CreateParticipantEvent extends AuthEvent {
  CreateParticipantEvent(
      {required this.fname,
      required this.lname,
      required this.email,
      required this.phone,
      required this.role,
      required this.city,
      required this.state,
      required this.country,
      required this.zipcode,
      this.weight,
      this.dob,
      this.gender,
      required this.eventId,
      required this.context});

  final String fname;
  final String lname;
  final String eventId;
  DateTime? dob;
  double? weight;
  String? gender;
  final String email;
  final String phone;
  final String role;

  final String city;
  final String state;
  final String country;
  final String zipcode;
  BuildContext context;
}
