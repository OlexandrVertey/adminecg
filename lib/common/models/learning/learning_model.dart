class LearningModel {
  final String id;
  final String categoryId;
  final String diagnoseId;
  final bool isPremium;
  final List<ElementModel>? list;

  LearningModel({
    required this.id,
    required this.categoryId,
    required this.diagnoseId,
    required this.isPremium,
    required this.list,
  });

  factory LearningModel.fromJson(Map<String, dynamic> json) => LearningModel(
    id: json["id"],
    categoryId: json["categoryId"],
    diagnoseId: json["diagnoseId"],
    isPremium: json["isPremium"],
    list: json["list"] != null
        ? List<ElementModel>.from(json["list"].map((x) => ElementModel.fromJson(x)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryId": categoryId,
    "diagnoseId": diagnoseId,
    "isPremium": isPremium,
    "list": list != null
        ? List<dynamic>.from(list!.map((x) => x.toJson()))
        : null,
  };
}

class ElementModel {
  final String en;
  final String he;
  final ElementType type;

  ElementModel({
    required this.en,
    required this.he,
    required this.type,
  });

  factory ElementModel.fromJson(Map<String, dynamic> json) => ElementModel(
    en: json["en"],
    he: json["he"],
    type: ElementTypeExtension.fromString(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "he": he,
    "type": type.toShortString(),
  };
}

enum ElementType { image, text }

extension ElementTypeExtension on ElementType {
  static ElementType fromString(String type) {
    switch (type) {
      case 'image':
        return ElementType.image;
      case 'text':
        return ElementType.text;
      default:
        throw Exception('Unknown ElementType: $type');
    }
  }

  String toShortString() {
    return toString().split('.').last;
  }
}