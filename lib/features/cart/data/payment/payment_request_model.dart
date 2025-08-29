import 'package:equatable/equatable.dart';

class PaymentRequestModel extends Equatable {
  final int amount;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  const PaymentRequestModel({
    required this.amount,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "fName": firstName,
    "lName": lastName,
    "email": email,
    "phoneNumber": phoneNumber,
  };

  @override
  List<Object> get props => [amount, firstName, lastName, email, phoneNumber];
}
