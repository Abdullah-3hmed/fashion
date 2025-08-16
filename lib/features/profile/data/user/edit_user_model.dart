import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_fashion_flutter/features/profile/data/user_model.dart';
import 'package:equatable/equatable.dart';

class EditUserModel extends Equatable {
  final String userName;
  final String phone;
  final String email;
  final String profileImage;
  final File? profileImageFile;

  const EditUserModel({
    required this.userName,
    required this.phone,
    this.profileImage = "",
    required this.email,
    this.profileImageFile,
  });

  factory EditUserModel.fromJson(Map<String, dynamic> json) => EditUserModel(
    userName: json["fullName"] ?? "",
    phone: json["phoneNumber"] ?? "",
    profileImage: json["profilePicture"] ?? "",
    email: json["email"] ?? "",
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "FullName": userName,
      "PhoneNumber": phone,
      "Email": email,
    };

    if (profileImageFile != null) {
      data["ProfilePicture"] = MultipartFile.fromFileSync(
        profileImageFile!.path,
        filename: profileImageFile!.path.split('/').last,
      );
    }

    return data;
  }

  static const EditUserModel empty = EditUserModel(
    email: '',
    userName: '',
    phone: '',
  );

  EditUserModel copyWith({File? profileImageFile}) => EditUserModel(
    userName: userName,
    phone: phone,
    profileImage: profileImage,
    profileImageFile: profileImageFile ?? this.profileImageFile,
    email: email,
  );

  @override
  List<Object?> get props => [
    userName,
    phone,
    profileImage,
    profileImageFile,
    email,
  ];
}
