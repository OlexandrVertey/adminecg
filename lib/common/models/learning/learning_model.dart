class LearningModel {
  final String id;
  final String categoryId;
  final String diagnoseId;
  final bool isPremium;
  final String titleEn;
  final String titleHe;
  final String descriptionEn;
  final String descriptionHe;
  final String imageEn;
  final String imageHe;

  LearningModel({
    required this.id,
    required this.categoryId,
    required this.diagnoseId,
    required this.isPremium,
    required this.titleEn,
    required this.titleHe,
    required this.descriptionEn,
    required this.descriptionHe,
    required this.imageEn,
    required this.imageHe,
  });

  factory LearningModel.fromJson(Map<String, dynamic> json) => LearningModel(
    id: json["id"],
    categoryId: json["categoryId"],
    diagnoseId: json["diagnoseId"],
    isPremium: json["isPremium"],
    titleEn: json["titleEn"],
    titleHe: json["titleHe"],
    descriptionEn: json["descriptionEn"],
    descriptionHe: json["descriptionHe"],
    imageEn: json["imageEn"],
    imageHe: json["imageHe"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryId": categoryId,
    "diagnoseId": diagnoseId,
    "isPremium": isPremium,
    "titleEn": titleEn,
    "titleHe": titleHe,
    "descriptionEn": descriptionEn,
    "descriptionHe": descriptionHe,
    "imageEn": imageEn,
    "imageHe": imageHe,
  };
}