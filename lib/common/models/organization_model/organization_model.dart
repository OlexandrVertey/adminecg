class OrganizationModel {
  String? id;
  String? name;
  String? premium;

  OrganizationModel({
    this.id,
    this.name,
    this.premium,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) => OrganizationModel(
    id: json["id"],
    name: json["name"],
    premium: json["premium"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "premium": premium,
  };
}