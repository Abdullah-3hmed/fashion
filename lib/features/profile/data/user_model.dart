import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userName;
  final String email;
  final String phone;
  final String profileImage;
  final String fcmToken;

  const UserModel({
    required this.userName,
    required this.email,
    required this.phone,
    required this.fcmToken,
    required this.profileImage,
  });
  static const UserModel empty = UserModel(
    userName: '',
    phone: '',
    profileImage: '',
    email: '',
    fcmToken: '',
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userName: json["userName"],
    email: json["email"],
    phone: json["phone"],
    profileImage: json["imageUrl"],
    fcmToken: json["fcmToken"] ?? "",
  );

  Map<String, dynamic> toJson({
    String? userName,
    String? email,
    String? phone,
    String? profileImage,
  }) => {
    "userName": userName ?? this.userName,
    "email": email ?? this.email,
    "phone": phone ?? this.phone,
    "imageUrl": profileImage ?? this.profileImage,
  };

  UserModel copyWith({
    String? userName,
    String? email,
    String? phone,
    String? profileImage,
    String? fcmToken,
  }) {
    return UserModel(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  @override
  List<Object?> get props => [userName, email, phone, profileImage];
}
