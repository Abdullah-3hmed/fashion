import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class EditUserModel extends Equatable {
  final String userName;
  final String phone;
  final String profileImage;
  final File? profileImageFile;

  const EditUserModel({
    required this.userName,
    required this.phone,
    required this.profileImage,
    this.profileImageFile,
  });

  factory EditUserModel.fromJson(Map<String, dynamic> json) => EditUserModel(
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

  static const EditUserModel empty = EditUserModel(
    userName: '',
    phone: '',
    profileImage: '',
  );

  EditUserModel copyWith({
    String? userName,
    String? phone,
    String? profileImage,
    File? profileImageFile,
  }) => EditUserModel(
    userName: userName ?? this.userName,
    phone: phone ?? this.phone,
    profileImage: profileImage ?? this.profileImage,
    profileImageFile: profileImageFile ?? this.profileImageFile,
  );

  @override
  List<Object?> get props => [userName, phone, profileImage, profileImageFile];
}
