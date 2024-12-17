class EventModel {
  final String id;
  final String image;
  final String text;
  final String correctAnswer;
  final String answerA;
  final String answerB;
  final String answerC;
  final String answerD;
  final bool isPremium;

  EventModel({
    required this.id,
    required this.image,
    required this.text,
    required this.correctAnswer,
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
    required this.isPremium,
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
      };
}
