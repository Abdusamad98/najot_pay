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
  AuthBloc({required this.authRepository}) : super(AuthState.init()) {
    on<CheckAuthenticationEvent>(_checkAuthentication);
    on<LoginUserEvent>(_loginUser);
    on<RegisterUserEvent>(_registerUser);
    on<LogOutUserEvent>(_logOutUser);
    on<SignInWithGoogleEvent>(_googleSignIn);
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
      email: "${event.username.toLowerCase()}@gmail.com",
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
      debugPrint("REGISTERED USER!!!");

      UserCredential userCredential = networkResponse.data as UserCredential;
      UserModel userModel = state.userModel.copyWith(
        authUid: userCredential.user!.uid,
      );
      emit(
        state.copyWith(
          status: FormsStatus.authenticated,
          statusMessage: "registered",
          userModel: userModel,
        ),
      );
    } else {
      debugPrint("ERROR REGISTER USER!!! ${networkResponse.errorCode}");
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
          statusMessage: "registered",
          status: FormsStatus.authenticated,
          userModel: UserModel(
            fcm: "",
            authUid: userCredential.user!.uid,
            password: "",
            email: userCredential.user!.email ?? "",
            imageUrl: userCredential.user!.photoURL ?? "",
            lastname: userCredential.user!.displayName ?? "",
            phoneNumber: userCredential.user!.phoneNumber ?? "",
            userId: "",
            username: userCredential.user!.displayName ?? "",
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
}
