part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String errorMessage;
  final String statusMessage;
  final FormsStatus status;
  final UserModel userModel;

  const AuthState({
    required this.status,
    required this.errorMessage,
    required this.statusMessage,
    required this.userModel,
  });

  AuthState copyWith({
    String? errorMessage,
    String? statusMessage,
    FormsStatus? status,
    UserModel? userModel,
  }) {
    return AuthState(
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      userModel: userModel ?? this.userModel,
    );
  }

  factory AuthState.init() {
    return AuthState(
      status: FormsStatus.pure,
      statusMessage: '',
      errorMessage: '',
      userModel: UserModel.initial(),
    );
  }

  @override
  List<Object?> get props => [
        status,
        statusMessage,
        errorMessage,
        userModel,
      ];
}
