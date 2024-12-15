class DiagnosisModel {
  final String id;
  final String titleEn;
  final String titleHe;

  DiagnosisModel(
      {required this.id, required this.titleEn, required this.titleHe});

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) => DiagnosisModel(
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
