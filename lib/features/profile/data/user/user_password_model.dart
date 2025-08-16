import 'package:equatable/equatable.dart';

class UserPasswordModel extends Equatable {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const UserPasswordModel({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
    "oldPassword": currentPassword,
    "newPassword": newPassword,
    "newPasswordComfirmation": confirmPassword,
  };

  @override
  List<Object> get props => [currentPassword, newPassword, confirmPassword];
}
