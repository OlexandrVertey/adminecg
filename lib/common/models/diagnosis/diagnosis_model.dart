class DiagnoseModel {
  final String id;
  final String titleEn;

  DiagnoseModel(
      {required this.id, required this.titleEn});

  factory DiagnoseModel.fromJson(Map<String, dynamic> json) => DiagnoseModel(
        id: json["id"],
        titleEn: json["titleEn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titleEn": titleEn,
      };
}
