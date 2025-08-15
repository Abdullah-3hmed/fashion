import 'package:equatable/equatable.dart';

class AuthResponseModel extends Equatable {
  final String message;
  final String token;
  final String userId;

  const AuthResponseModel({
    required this.message,
    required this.token,
    required this.userId,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        message: json["message"] ?? "",
        token: json["data"]?["token"] ?? "",
        userId: json["data"]?["userId"] ?? "",
      );

  static const AuthResponseModel empty = AuthResponseModel(
    message: "",
    token: "",
    userId: "",
  );

  @override
  List<Object> get props => [message, token, userId];
}
