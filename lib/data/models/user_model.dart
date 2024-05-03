class UserModel {
  final String username;
  final String fullName;
  final String password;
  final String email;
  final String imageUrl;
  final String phoneNumber;
  final String userId;
  final String authUid;
  final String fcm;

  UserModel({
    required this.password,
    required this.email,
    required this.imageUrl,
    required this.fullName,
    required this.phoneNumber,
    required this.userId,
    required this.username,
    required this.fcm,
    required this.authUid,
  });

  UserModel copyWith({
    String? username,
    String? lastname,
    String? password,
    String? email,
    String? imageUrl,
    String? phoneNumber,
    String? userId,
    String? fcm,
    String? authUid,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      fullName: lastname ?? this.fullName,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fcm: fcm ?? this.fcm,
      authUid: authUid ?? this.authUid,
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "lastname": fullName,
        "username": username,
        "email": email,
        "password": password,
        "imageUrl": imageUrl,
        "phoneNumber": phoneNumber,
        "fcm": fcm,
        "authUid": authUid,
      };


  Map<String, dynamic> toJsonForUpdate() => {
    "lastname": fullName,
    "username": username,
    "email": email,
    "password": password,
    "imageUrl": imageUrl,
    "phoneNumber": phoneNumber,
    "fcm": fcm,
    "authUid": authUid,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      password: json["password"] as String? ?? "",
      email: json["email"] as String? ?? "",
      imageUrl: json["imageUrl"] as String? ?? "",
      fullName: json["lastname"] as String? ?? "",
      phoneNumber: json["phoneNumber"] as String? ?? "",
      userId: json["userId"] as String? ?? "",
      username: json["username"] as String? ?? "",
      fcm: json["fcm"] as String? ?? "",
      authUid: json["authUid"] as String? ?? "",
    );
  }

  static UserModel initial() => UserModel(
        password: "",
        email: "",
        imageUrl: "",
        fullName: "",
        phoneNumber: "",
        userId: "",
        username: "",
        fcm: "",
    authUid: "",
      );
}
