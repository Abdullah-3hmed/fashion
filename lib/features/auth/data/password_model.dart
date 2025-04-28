import 'package:equatable/equatable.dart';

class PasswordModel extends Equatable {
  final String email;
  final int otp;
  final String token;

  const PasswordModel({
    required this.email,
    required this.otp,
    required this.token,
  });

  static const PasswordModel empty = PasswordModel(
    email: '',
    otp: 0,
    token: '',
  );

  factory PasswordModel.fromJson(Map<String, dynamic> json) => PasswordModel(
    email: json["email"],
    otp: json["otp"],
    token: json["token"] ?? "",
  );

  @override
  List<Object> get props => [email, otp, token];
}
