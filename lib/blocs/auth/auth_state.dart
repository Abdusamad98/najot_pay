part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String errorMessage;
  final String statusMessage;
  final FormsStatus status;
  final UserModel userModel;
  final bool isValid;
  final bool isError;

  const AuthState({
    required this.status,
    required this.errorMessage,
    required this.statusMessage,
    required this.userModel,
    required this.isValid,
    required this.isError,
  });

  AuthState copyWith({
    String? errorMessage,
    String? statusMessage,
    FormsStatus? status,
    UserModel? userModel,
    bool? isValid,
    bool? isError,
  }) {
    return AuthState(
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      userModel: userModel ?? this.userModel,
      isValid: isValid ?? this.isValid,
      isError: isError ?? this.isError,
    );
  }

  factory AuthState.init() {
    return AuthState(
      status: FormsStatus.pure,
      statusMessage: '',
      errorMessage: '',
      userModel: UserModel.initial(),
      isValid: false,
      isError: false,
    );
  }

  @override
  List<Object?> get props => [
        status,
        statusMessage,
        errorMessage,
        userModel,
        isValid,
        isError,
      ];
}
