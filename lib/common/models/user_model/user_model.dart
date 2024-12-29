class UserModel {
  String? userUid;
  String? fullName;
  String? email;
  String? password;
  String? organisation;

  UserModel({
    this.userUid,
    this.fullName,
    this.email,
    this.password,
    this.organisation,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userUid: json["userUid"],
    fullName: json["fullName"],
    email: json["email"],
    password: json["password"],
    organisation: json["organisation"],
  );

  Map<String, dynamic> toJson() => {
    "userUid": userUid,
    "fullName": fullName,
    "email": email,
    "password": password,
    "organisation": organisation,
  };
}