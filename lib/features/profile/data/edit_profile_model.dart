import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class EditProfileModel extends Equatable {
  final String userName;
  final String phone;
  final String profileImage;
  final File? profileImageFile;

  const EditProfileModel({
    required this.userName,
    required this.phone,
    required this.profileImage,
    this.profileImageFile,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) =>
      EditProfileModel(
        userName: json["username"],
        phone: json["phone"],
        profileImage: json["photo"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {"userName": userName, "phone": phone};

    if (profileImageFile != null) {
      data["photo"] = MultipartFile.fromFileSync(
        profileImageFile!.path,
        filename: profileImageFile!.path.split('/').last,
      );
    }

    return data;
  }

  static const EditProfileModel empty = EditProfileModel(
    userName: '',
    phone: '',
    profileImage: '',
  );

  @override
  List<Object?> get props => [userName, phone, profileImage, profileImageFile];
}
