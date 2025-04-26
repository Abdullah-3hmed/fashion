import 'package:equatable/equatable.dart';

class SingUpResponseModel extends Equatable {
  final String message;
  final String token;

  const SingUpResponseModel({required this.message, required this.token});

  factory SingUpResponseModel.fromJson(Map<String, dynamic> json) =>
      SingUpResponseModel(message: json["message"], token: json["token"]);

  @override
  List<Object> get props => [message, token];
}

class SignUpRequestModel extends Equatable {
  final String userName;
  final String email;
  final String password;
  final String phone;
  final String fcmToken;

  const SignUpRequestModel({
    required this.userName,
    required this.email,
    required this.password,
    required this.phone,
    required this.fcmToken,
  });

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "email": email,
    "password": password,
    "confirmPassword": password,
    "phoneNumber": phone,
    "fcmToken": fcmToken,
  };

  @override
  List<Object> get props => [userName, email, password, fcmToken];
}
