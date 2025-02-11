import 'package:adminecg/common/models/learning/learning_model.dart';

class EventModel {
  final String id;
  final String image;
  final String? text;
  final String correctAnswer;
  final String answerA;
  final String answerB;
  final String answerC;
  final String answerD;
  final bool isPremium;
  final List<ElementModel>? list;

  EventModel({
    required this.id,
    required this.image,
    this.text,
    required this.correctAnswer,
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
    required this.isPremium,
    required this.list,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        image: json["image"],
        text: json["text"],
        correctAnswer: json["correctAnswer"],
        answerA: json["answerA"],
        answerB: json["answerB"],
        answerC: json["answerC"],
        answerD: json["answerD"],
        isPremium: json["isPremium"],
        list: json["list"] != null ? List<ElementModel>.from(json["list"].map((x) => ElementModel.fromJson(x))) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "text": text,
        "correctAnswer": correctAnswer,
        "answerA": answerA,
        "answerB": answerB,
        "answerC": answerC,
        "answerD": answerD,
        "isPremium": isPremium,
        "list": list != null ? List<dynamic>.from(list!.map((x) => x.toJson())) : null,
      };
}