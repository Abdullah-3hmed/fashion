import 'package:equatable/equatable.dart';

class AuthResponseModel extends Equatable {
  final String message;
  final String token;

  const AuthResponseModel({required this.message, required this.token});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(message: json["message"], token: json["token"]);

  static const AuthResponseModel empty = AuthResponseModel(
    message: "",
    token: "",
  );

  @override
  List<Object> get props => [message, token];
}
