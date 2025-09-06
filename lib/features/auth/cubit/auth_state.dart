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
  final String authErrorMessage;


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
    this.authErrorMessage = '',
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
    String?authErrorMessage,
    String? verifyOtpMessage,
    String? resetPasswordMessage,
  }) => AuthState(
    authResponseModel: authResponseModel ?? this.authResponseModel,
    loginRequestStatus: loginRequestStatus ?? this.loginRequestStatus,
    signUpRequestStatus: signUpRequestStatus ?? this.signUpRequestStatus,
    forgetPasswordRequestStatus:
        forgetPasswordRequestStatus ?? this.forgetPasswordRequestStatus,
    resetPasswordRequestStatus:
        resetPasswordRequestStatus ?? this.resetPasswordRequestStatus,
    verifyOtpRequestStatus:
        verifyOtpRequestStatus ?? this.verifyOtpRequestStatus,
    authErrorMessage: authErrorMessage??this.authErrorMessage,
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
    authErrorMessage,
    verifyOtpMessage,
    resetPasswordMessage,
  ];
}
