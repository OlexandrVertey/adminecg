class DiagnoseModel {
  final String id;
  final String titleEn;
  final String titleHe;

  DiagnoseModel(
      {required this.id, required this.titleEn, required this.titleHe});

  factory DiagnoseModel.fromJson(Map<String, dynamic> json) => DiagnoseModel(
        id: json["id"],
        titleEn: json["titleEn"],
        titleHe: json["titleHe"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titleEn": titleEn,
        "titleHe": titleHe,
      };
}
