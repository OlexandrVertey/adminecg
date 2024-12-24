class TopicModel {
  final String id;
  final String titleEn;

  TopicModel(
      {required this.id, required this.titleEn});

  factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
    id: json["id"],
    titleEn: json["titleEn"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "titleEn": titleEn,
  };
}
