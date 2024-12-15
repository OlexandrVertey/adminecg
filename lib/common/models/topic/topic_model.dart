class TopicModel {
  final String id;
  final String titleEn;
  final String titleHe;

  TopicModel(
      {required this.id, required this.titleEn, required this.titleHe});

  factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
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
