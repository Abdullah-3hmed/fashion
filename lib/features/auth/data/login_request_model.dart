import 'package:equatable/equatable.dart';

class LoginRequestModel extends Equatable {
  final String email;
  final String password;
  final String fcmToken;
  const LoginRequestModel({
    required this.email,
    required this.password,
    required this.fcmToken,
  });
  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "fcM_Token": fcmToken,
  };
  @override
  List<Object> get props => [email, password, fcmToken];
}
