class Card {
  int id;
  String question;
  String? questionImageUrl;
  String? answer;
  List<String>? answerImageUrls;

  Card({
    required this.id,
    required this.question,
    this.questionImageUrl,
    this.answer,
    this.answerImageUrls,
  });

  static Card fromJson(Map<String, Object?> json) {
    List<String>? answerImages;
    String? questionImage;
    String? answer;

    if (json["answer_images"] != null) {
      answerImages = [];
      var answerImagesJson = json["answer_images"] as List<dynamic>;
      for (int i = 0; i < answerImagesJson.length; i++) {
        answerImages.add(answerImagesJson[i] as String);
      }
    }

    if (json["question_image"] != null) {
      questionImage = json["question_image"] as String;
    }

    if (json["answer_text"] != null) {
      answer = json["answer_text"] as String;
    }

    return Card(
      id: json["card_id"] as int,
      question: json["question_text"] as String,
      questionImageUrl: questionImage,
      answer: answer,
      answerImageUrls: answerImages,
    );
  }
}
