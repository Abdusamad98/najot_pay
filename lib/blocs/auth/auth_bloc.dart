// ignore_for_file: unused_local_variable

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najot_pay/data/models/forms_status.dart';
import 'package:najot_pay/data/models/network_response.dart';
import 'package:najot_pay/data/models/user_model.dart';
import 'package:najot_pay/data/repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository})
      : super(
          AuthState.init(),
        ) {
    on<CheckAuthenticationEvent>(_checkAuthentication);
    on<LoginUserEvent>(_loginUser);
    on<RegisterUserEvent>(_registerUser);
    on<LogOutUserEvent>(_logOutUser);
    on<SignInWithGoogleEvent>(_googleSignIn);
    on<IsValidToInsert>(_isValidToInsert);
  }

  final AuthRepository authRepository;

  _checkAuthentication(CheckAuthenticationEvent event, emit) async {
    User? user = FirebaseAuth.instance.currentUser;

    debugPrint("CURRENT USER:$user");
    if (user == null) {
      emit(state.copyWith(status: FormsStatus.unauthenticated));
    } else {
      emit(state.copyWith(status: FormsStatus.authenticated));
    }
  }

  _loginUser(LoginUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse =
        await authRepository.logInWithEmailAndPassword(
      email: event.username,
      password: event.password,
    );
    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(status: FormsStatus.authenticated));
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _registerUser(RegisterUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse =
        await authRepository.registerWithEmailAndPassword(
      email: event.userModel.email,
      password: event.userModel.password,
    );
    if (networkResponse.errorText.isEmpty) {
      UserCredential userCredential = networkResponse.data;
      emit(
        state.copyWith(
          status: FormsStatus.authenticated,
          statusMessage: "registered",
          userModel: event.userModel,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _logOutUser(LogOutUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse = await authRepository.logOutUser();
    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(status: FormsStatus.unauthenticated));
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _googleSignIn(SignInWithGoogleEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse = await authRepository.googleSignIn();
    if (networkResponse.errorText.isEmpty) {
      UserCredential userCredential = networkResponse.data;
      emit(
        state.copyWith(
          // statusMessage: "registered",
          status: FormsStatus.authenticated,
          userModel: UserModel(
            password: "",
            email: userCredential.user!.email ?? "",
            imageUrl: userCredential.user!.photoURL ?? "",
            lastname: userCredential.user!.displayName ?? "",
            phoneNumber: userCredential.user!.phoneNumber ?? "",
            userId: "",
            username: "",
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _isValidToInsert(IsValidToInsert event, emit) {
    emit(state.copyWith(status: FormsStatus.loading));
    if (event.passwordController.isNotEmpty &&
        event.gmailController.isNotEmpty &&
        event.usernameController.isNotEmpty &&
        event.lastnameController.isNotEmpty &&
        event.confirmPasswordController.isNotEmpty) {
      emit(state.copyWith(isValid: true,status: FormsStatus.error));
      return;
    }
    emit(state.copyWith(
        isError: true, errorMessage: "Maydonlarni to'liq kiriting"));
  }
}
