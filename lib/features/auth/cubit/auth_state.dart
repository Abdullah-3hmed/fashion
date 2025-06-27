import 'package:e_fashion_flutter/core/enums/request_status.dart';
import 'package:e_fashion_flutter/features/auth/data/auth_response_model.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  // Data
  final AuthResponseModel authResponseModel;

  // Request Statuses
  final RequestStatus loginRequestStatus;
  final RequestStatus signUpRequestStatus;
  final RequestStatus forgetPasswordRequestStatus;
  final RequestStatus resetPasswordRequestStatus;
  final RequestStatus verifyOtpRequestStatus;

  // Error Messages
  final String loginErrorMessage;
  final String signUpErrorMessage;
  final String forgetPasswordErrorMessage;
  final String resetPasswordErrorMessage;
  final String verifyOtpErrorMessage;

  // Success Messages
  final String verifyOtpMessage;
  final String resetPasswordMessage;

  const AuthState({
    this.authResponseModel = AuthResponseModel.empty,
    this.loginRequestStatus = RequestStatus.initial,
    this.signUpRequestStatus = RequestStatus.initial,
    this.forgetPasswordRequestStatus = RequestStatus.initial,
    this.resetPasswordRequestStatus = RequestStatus.initial,
    this.verifyOtpRequestStatus = RequestStatus.initial,
    this.loginErrorMessage = '',
    this.signUpErrorMessage = '',
    this.forgetPasswordErrorMessage = '',
    this.resetPasswordErrorMessage = '',
    this.verifyOtpErrorMessage = '',
    this.verifyOtpMessage = '',
    this.resetPasswordMessage = '',
  });

  AuthState copyWith({
    AuthResponseModel? authResponseModel,
    RequestStatus? loginRequestStatus,
    RequestStatus? signUpRequestStatus,
    RequestStatus? forgetPasswordRequestStatus,
    RequestStatus? resetPasswordRequestStatus,
    RequestStatus? verifyOtpRequestStatus,
    String? loginErrorMessage,
    String? signUpErrorMessage,
    String? forgetPasswordErrorMessage,
    String? resetPasswordErrorMessage,
    String? verifyOtpErrorMessage,
    String? verifyOtpMessage,
    String? resetPasswordMessage,
  }) =>
      AuthState(
        authResponseModel: authResponseModel ?? this.authResponseModel,
        loginRequestStatus: loginRequestStatus ?? this.loginRequestStatus,
        signUpRequestStatus: signUpRequestStatus ?? this.signUpRequestStatus,
        forgetPasswordRequestStatus:
        forgetPasswordRequestStatus ?? this.forgetPasswordRequestStatus,
        resetPasswordRequestStatus:
        resetPasswordRequestStatus ?? this.resetPasswordRequestStatus,
        verifyOtpRequestStatus:
        verifyOtpRequestStatus ?? this.verifyOtpRequestStatus,
        loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
        signUpErrorMessage: signUpErrorMessage ?? this.signUpErrorMessage,
        forgetPasswordErrorMessage:
        forgetPasswordErrorMessage ?? this.forgetPasswordErrorMessage,
        resetPasswordErrorMessage:
        resetPasswordErrorMessage ?? this.resetPasswordErrorMessage,
        verifyOtpErrorMessage:
        verifyOtpErrorMessage ?? this.verifyOtpErrorMessage,
        verifyOtpMessage: verifyOtpMessage ?? this.verifyOtpMessage,
        resetPasswordMessage: resetPasswordMessage ?? this.resetPasswordMessage,
      );

  @override
  List<Object> get props => [
    authResponseModel,
    loginRequestStatus,
    signUpRequestStatus,
    forgetPasswordRequestStatus,
    resetPasswordRequestStatus,
    verifyOtpRequestStatus,
    loginErrorMessage,
    signUpErrorMessage,
    forgetPasswordErrorMessage,
    resetPasswordErrorMessage,
    verifyOtpErrorMessage,
    verifyOtpMessage,
    resetPasswordMessage,
  ];
}
