import 'package:equatable/equatable.dart';

class PaymentSuccessModel extends Equatable {
  final bool success;
  final String date;
  final String time;
  final String firstName;
  final String lastName;
  final String deliveryDate;
  final num amount;

  const PaymentSuccessModel({
    required this.success,
    required this.date,
    required this.firstName,
    required this.lastName,
    required this.amount,
    required this.deliveryDate,
    required this.time,
  });

  factory PaymentSuccessModel.fromJson(Map<String, dynamic> json) =>
      PaymentSuccessModel(
        success: json["success"] ?? false,
        date: json["date"] ?? "",
        firstName: json["fName"] ?? "",
        lastName: json["lName"] ?? "",
        amount: json["orderPrice"] ?? 0,
        deliveryDate: json["deliveryDate"] ?? "",
        time: json["time"] ?? "",
      );
  static const empty = PaymentSuccessModel(
    success: false,
    date: "",
    firstName: "",
    lastName: "",
    amount: 0,
    deliveryDate: "",
    time: "",
  );

  @override
  List<Object> get props => [
    success,
    date,
    firstName,
    lastName,
    amount,
    deliveryDate,
    time,
  ];
}
