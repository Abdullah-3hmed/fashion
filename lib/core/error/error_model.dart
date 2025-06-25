import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  final int statusCode;
  final List<String> errors;

  const ErrorModel({required this.statusCode, required this.errors});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    statusCode: json["statusCode"],
    errors: List<String>.from(json["errors"]),
  );

  @override
  List<Object> get props => [statusCode, errors];
}
