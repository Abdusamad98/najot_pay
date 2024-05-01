part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckAuthenticationEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LoginUserEvent extends AuthEvent {
  final String username;
  final String password;

  LoginUserEvent({
    required this.password,
    required this.username,
  });

  @override
  List<Object?> get props => [
        password,
        username,
      ];
}

class RegisterUserEvent extends AuthEvent {
  final UserModel userModel;

  RegisterUserEvent({required this.userModel});

  @override
  List<Object?> get props => [
        userModel,
      ];
}

class LogOutUserEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class IsValidToInsert extends AuthEvent {
  final String passwordController;
  final String usernameController;
  final String gmailController;
  final String lastnameController;
  final String phoneController;
  final String confirmPasswordController;

  IsValidToInsert({
    required this.passwordController,
    required this.usernameController,
    required this.gmailController,
    required this.lastnameController,
    required this.phoneController,
    required this.confirmPasswordController,
  });

  @override
  List<Object?> get props => [
        passwordController,
        usernameController,
        gmailController,
        lastnameController,
        phoneController,
        confirmPasswordController,
      ];
}

class SignInWithGoogleEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
