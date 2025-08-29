import 'package:equatable/equatable.dart';

class PaymentSuccessModel extends Equatable {
  final bool success;
  final String createdAt;
  final String firstName;
  final String lastName;
  final num amount;

  const PaymentSuccessModel({
    required this.success,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.amount,
  });

  factory PaymentSuccessModel.fromJson(Map<String, dynamic> json) =>
      PaymentSuccessModel(
        success: json["success"] ?? false,
        createdAt: json["created_at"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        amount: json["amount_cents"] ?? 0,
      );
  static const empty = PaymentSuccessModel(
    success: false,
    createdAt: "",
    firstName: "",
    lastName: "",
    amount: 0,
  );

  @override
  List<Object> get props => [success, createdAt, firstName, lastName, amount];
}
