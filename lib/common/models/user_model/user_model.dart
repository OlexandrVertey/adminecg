class UserModel {
  String? userUid;
  String? fullName;
  String? email;
  String? password;

  UserModel({
    this.userUid,
    this.fullName,
    this.email,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userUid: json["userUid"],
    fullName: json["fullName"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "userUid": userUid,
    "fullName": fullName,
    "email": email,
    "password": password,
  };
}