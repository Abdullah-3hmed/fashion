import 'package:e_fashion_flutter/features/auth/data/auth_response_model.dart';
import 'package:equatable/equatable.dart';

sealed class AuthStates extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthStates {}

class SignUpLoadingState extends AuthStates {}

class SignUpSuccessState extends AuthStates {
  final AuthResponseModel authResponseModel;

  SignUpSuccessState({required this.authResponseModel});

  @override
  List<Object> get props => [authResponseModel];
}

class SignUpErrorState extends AuthStates {
  final String errorMessage;

  SignUpErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  final AuthResponseModel authResponseModel;

  LoginSuccessState({required this.authResponseModel});

  @override
  List<Object> get props => [authResponseModel];
}

class LoginErrorState extends AuthStates {
  final String errorMessage;

  LoginErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
