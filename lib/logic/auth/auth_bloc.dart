import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_app/config/screen_config.dart';
import 'package:my_app/config/shared_prefs_config.dart';
import 'package:my_app/models/auth_model.dart';
import 'package:my_app/screen/home/home_screen.dart';

import '../../repo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    final authRepo = AuthRepository();

    AuthModel? authModel;

    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(AuthState(isLoading: true));

        final response = await authRepo.logInUser(
          phone: event.phoneNum,
          password: event.password,
        );

        if (response != null) {
          // Check if response contains an error (e.g., 'detail' key)
          if (response.containsKey('detail')) {
            // Extract the error message from the 'detail' field
            String errorMessage =
                response['detail'] ?? 'An unknown error occurred';
            emit(AuthState(isLoading: false, errorMessge: errorMessage));
            print("Auth failed: $errorMessage");
          } else {
            // If no error, proceed with the successful login
            authModel = AuthModel.fromJson(response);
            SharedPrefsConfig.saveBool(SharedPrefsConfig.keyIsLoggedIn, true);
            SharedPrefsConfig.saveUserData(
              userId: authModel?.userId ?? "",
              userName: authModel?.username ?? "",
              userEmail: "",
              userRole: authModel?.role ?? "",
              accessToken: authModel?.token ?? "",
            );

            // Navigate to HomeScreen after login
            pushReplaceScreen(event.context, HomeScreen());

            emit(AuthState(isLoading: false));
            print("Auth Success: $response");
          }
        } else {
          // If response is null (due to network issues or other problems)
          emit(AuthState(
              isLoading: false, errorMessge: 'An unknown error occurred'));
          print("Auth failed: Unknown error.");
        }
      }
    });
  }
}
