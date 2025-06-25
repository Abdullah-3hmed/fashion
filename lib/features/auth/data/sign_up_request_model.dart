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
    "FullName": userName,
    "Email": email,
    "Password": password,
    "PhoneNumber": phone,
    "FCM_Token": fcmToken,
  };

  @override
  List<Object> get props => [userName, phone, email, password, fcmToken];
}
