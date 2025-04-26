import 'package:e_fashion_flutter/features/auth/data/sign_up_model.dart';
import 'package:equatable/equatable.dart';

sealed class AuthStates extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpInitialState extends AuthStates {}

class SignUpLoadingState extends AuthStates {}

class SignUpSuccessState extends AuthStates {
  final SingUpResponseModel signUpResponseModel;

  SignUpSuccessState({required this.signUpResponseModel});

  @override
  List<Object> get props => [signUpResponseModel];
}

class SignUpErrorState extends AuthStates {
  final String errorMessage;

  SignUpErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
