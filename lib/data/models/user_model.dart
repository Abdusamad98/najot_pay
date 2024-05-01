class UserModel {
  final String username;
  final String lastname;
  final String password;
  final String email;
  final String imageUrl;
  final String phoneNumber;
  final String userId;

  UserModel({
    required this.password,
    required this.email,
    required this.imageUrl,
    required this.lastname,
    required this.phoneNumber,
    required this.userId,
    required this.username,
  });

  UserModel copyWith({
    String? username,
    String? lastname,
    String? password,
    String? email,
    String? imageUrl,
    String? phoneNumber,
    String? userId,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      lastname: lastname ?? this.lastname,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "lastname": lastname,
        "username": username,
        "email": email,
        "password": password,
        "imageUrl": imageUrl,
        "phoneNumber": phoneNumber,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      password: json["password"] as String? ?? "",
      email: json["email"] as String? ?? "",
      imageUrl: json["imageUrl"] as String? ?? "",
      lastname: json["lastname"] as String? ?? "",
      phoneNumber: json["phoneNumber"] as String? ?? "",
      userId: json["userId"] as String? ?? "",
      username: json["username"] as String? ?? "",
    );
  }

  static UserModel initial() => UserModel(
        password: "",
        email: "",
        imageUrl: "",
        lastname: "",
        phoneNumber: "",
        userId: "",
        username: "",
      );
}