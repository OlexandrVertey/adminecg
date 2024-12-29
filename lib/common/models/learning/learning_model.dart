
import 'dart:typed_data';

class LearningModel {
  final String id;
  final String categoryId;
  final String diagnoseId;
  final String selectedIcon;
  final bool isPremium;
  final List<ElementModel>? list;

  LearningModel({
    required this.id,
    required this.categoryId,
    required this.diagnoseId,
    required this.selectedIcon,
    required this.isPremium,
    required this.list,
  });

  factory LearningModel.fromJson(Map<String, dynamic> json) => LearningModel(
        id: json["id"],
        categoryId: json["categoryId"],
        diagnoseId: json["diagnoseId"],
        selectedIcon: json["selectedIcon"],
        isPremium: json["isPremium"],
        list: json["list"] != null
            ? List<ElementModel>.from(
                json["list"].map((x) => ElementModel.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "diagnoseId": diagnoseId,
        "selectedIcon": selectedIcon,
        "isPremium": isPremium,
        "list": list != null
            ? List<dynamic>.from(list!.map((x) => x.toJson()))
            : null,
      };
}

class ElementModel {
  final ElementType type;
  String? text;
  Uint8List? uint8list;

  ElementModel({
    required this.type,
    this.text,
    this.uint8list,
  });

  factory ElementModel.fromJson(Map<String, dynamic> json) => ElementModel(
        text: json["text"],
        type: ElementTypeExtension.fromString(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
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
