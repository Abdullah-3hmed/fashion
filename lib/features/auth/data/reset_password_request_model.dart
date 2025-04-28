import 'package:equatable/equatable.dart';

class ResetPasswordRequestModel extends Equatable {
  final String password;
  final String confirmPassword;
  final String token;
  final String email;

  const ResetPasswordRequestModel({
    required this.password,
    required this.confirmPassword,
    required this.token,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    "newPassword": password,
    "confirmPassword": confirmPassword,
    "token": token,
    "email": email,
  };

  @override
  List<Object> get props => [password, confirmPassword, token, email];
}
