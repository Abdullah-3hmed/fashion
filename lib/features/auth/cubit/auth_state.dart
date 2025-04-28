import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/auth/data/auth_response_model.dart';
import 'package:e_fashion_flutter/features/auth/data/password_model.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final AuthResponseModel authResponseModel;
  final PasswordModel passwordModel;
  final RequestStatus loginRequestStatus;
  final RequestStatus signUpRequestStatus;
  final String loginErrorMessage;
  final String signUpErrorMessage;
  final RequestStatus forgetPasswordRequestStatus;
  final RequestStatus resetPasswordRequestStatus;
  final RequestStatus emailVerificationRequestStatus;
  final String forgetPasswordErrorMessage;
  final String resetPasswordErrorMessage;
  final String emailVerificationErrorMessage;

  const AuthState({
    this.authResponseModel = AuthResponseModel.empty,
    this.passwordModel = PasswordModel.empty,
    this.loginRequestStatus = RequestStatus.initial,
    this.signUpRequestStatus = RequestStatus.initial,
    this.loginErrorMessage = '',
    this.signUpErrorMessage = '',
    this.forgetPasswordRequestStatus = RequestStatus.initial,
    this.resetPasswordRequestStatus = RequestStatus.initial,
    this.forgetPasswordErrorMessage = '',
    this.resetPasswordErrorMessage = '',
    this.emailVerificationRequestStatus = RequestStatus.initial,
    this.emailVerificationErrorMessage = '',
  });

  AuthState copyWith({
    AuthResponseModel? authResponseModel,
    PasswordModel? passwordModel,
    RequestStatus? loginRequestStatus,
    RequestStatus? signUpRequestStatus,
    String? loginErrorMessage,
    String? signUpErrorMessage,
    RequestStatus? forgetPasswordRequestStatus,
    RequestStatus? resetPasswordRequestStatus,
    RequestStatus? emailVerificationRequestStatus,
    String? forgetPasswordErrorMessage,
    String? resetPasswordErrorMessage,
    String? emailVerificationErrorMessage,
  }) => AuthState(
    authResponseModel: authResponseModel ?? this.authResponseModel,
    passwordModel: passwordModel ?? this.passwordModel,
    loginRequestStatus: loginRequestStatus ?? this.loginRequestStatus,
    signUpRequestStatus: signUpRequestStatus ?? this.signUpRequestStatus,
    loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
    signUpErrorMessage: signUpErrorMessage ?? this.signUpErrorMessage,
    forgetPasswordRequestStatus:
        forgetPasswordRequestStatus ?? this.forgetPasswordRequestStatus,
    resetPasswordRequestStatus:
        resetPasswordRequestStatus ?? this.resetPasswordRequestStatus,
    forgetPasswordErrorMessage:
        forgetPasswordErrorMessage ?? this.forgetPasswordErrorMessage,
    resetPasswordErrorMessage:
        resetPasswordErrorMessage ?? this.resetPasswordErrorMessage,
    emailVerificationRequestStatus:
        emailVerificationRequestStatus ?? this.emailVerificationRequestStatus,
    emailVerificationErrorMessage:
        emailVerificationErrorMessage ?? this.emailVerificationErrorMessage,
  );

  @override
  List<Object> get props => [
    authResponseModel,
    passwordModel,
    loginRequestStatus,
    signUpRequestStatus,
    loginErrorMessage,
    signUpErrorMessage,
    forgetPasswordRequestStatus,
    resetPasswordRequestStatus,
    emailVerificationRequestStatus,
    forgetPasswordErrorMessage,
    resetPasswordErrorMessage,
    emailVerificationErrorMessage,
  ];
}
