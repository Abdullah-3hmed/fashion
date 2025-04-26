import 'package:equatable/equatable.dart';

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
