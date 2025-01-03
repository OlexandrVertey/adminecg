class UserModel {
  String? userUid;
  String? fullName;
  String? email;
  String? password;
  String? organisation;
  String? startPlans;
  String? endPlans;
  String? plans;
  String? userRegisterDate;

  UserModel({
    this.userUid,
    this.fullName,
    this.email,
    this.password,
    this.organisation,
    this.startPlans,
    this.endPlans,
    this.plans,
    this.userRegisterDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userUid: json["userUid"],
    fullName: json["fullName"],
    email: json["email"],
    password: json["password"],
    organisation: json["organisation"],
    startPlans: json["startPlans"],
    endPlans: json["endPlans"],
    plans: json["plans"],
    userRegisterDate: json["userRegisterDate"],
  );

  Map<String, dynamic> toJson() => {
    "userUid": userUid,
    "fullName": fullName,
    "email": email,
    "password": password,
    "organisation": organisation,
    "startPlans": startPlans,
    "endPlans": endPlans,
    "plans": plans,
    "userRegisterDate": userRegisterDate,
  };
}