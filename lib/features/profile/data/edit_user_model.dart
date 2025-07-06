import 'dart:io';

import 'package:dio/dio.dart';
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
    userName: json["fullName"]??"",
    phone: json["phoneNumber"]??"",
    profileImage: json["profilePicture"]??"",
    email: json["email"]??"",
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

  EditUserModel copyWith({
    String? userName,
    String? phone,
    String? profileImage,
    File? profileImageFile,
    String? email,
  }) => EditUserModel(
    userName: userName ?? this.userName,
    phone: phone ?? this.phone,
    profileImage: profileImage ?? this.profileImage,
    profileImageFile: profileImageFile ?? this.profileImageFile,
    email: email ?? this.email,
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
