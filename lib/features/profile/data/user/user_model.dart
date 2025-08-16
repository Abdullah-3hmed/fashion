import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userName;
  final String email;
  final String phone;
  final String profileImage;
  final String fcmToken;
  final String token;

  const UserModel({
    required this.userName,
    required this.email,
    required this.phone,
    required this.fcmToken,
    required this.profileImage,
    required this.token,
  });

  static const UserModel empty = UserModel(
    userName: '',
    phone: '',
    profileImage: '',
    email: '',
    fcmToken: '',
    token: '',
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userName: json["fullName"] ?? "",
    email: json["email"] ?? "",
    phone: json["phoneNumber"] ?? "",
    profileImage: json["profilePicture"] ?? "",
    fcmToken: json["fcM_Token"] ?? "",
    token: json["token"] ?? "",
  );

  Map<String, dynamic> toJson({
    String? userName,
    String? email,
    String? phone,
    String? profileImage,
    String? fcmToken,
  }) => {
    "fullName": userName ?? this.userName,
    "email": email ?? this.email,
    "phoneNumber": phone ?? this.phone,
    "profilePicture": profileImage ?? this.profileImage,
    "fcM_Token": fcmToken ?? this.fcmToken,
  };

  UserModel copyWith({
    String? userName,
    String? email,
    String? phone,
    String? profileImage,
    String? fcmToken,
    String? token,
  }) {
    return UserModel(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      fcmToken: fcmToken ?? this.fcmToken,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [
    userName,
    email,
    phone,
    profileImage,
    fcmToken,
    token,
  ];
}
