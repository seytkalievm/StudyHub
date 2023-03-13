import 'package:flutter/material.dart';
import 'package:study_hub/presentation/session/create/create_card/add_cards_controller.dart';

class CreateCard {
  String _question = "";
  String? _answer;
  String? questionError;
  String? questionImageKey;
  List<String>? answerImages;
  List<String>? answerImageKeys;
  String? questionImage;

  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  CreateCard(AddCardsController controller) {
    questionController.addListener(() {
      _question = questionController.text.toString();
      questionError = null;
      controller.update();
    });

    answerController.addListener(() {
      _answer = answerController.text.toString();
      controller.update();
    });
  }

  bool isValid() {
    if (_question.isEmpty) {
      questionError = "Cannot be empty";

      return false;
    }

    return true;
  }

  Map<String, Object?> toJson(int question) {
    Map<String, Object?> json = {
      "question_text": _question.trim(),
    };

    if (questionImage != null) {
      questionImageKey = "question_$question";
      json["question_image_key"] = questionImageKey;
    }
    if (_answer != null) {
      json["answer_text"] = _answer!.trim();
    }
    if (answerImages != null) {
      answerImageKeys = [];
      for (int i = 0; i < answerImages!.length; i++) {
        answerImageKeys!.add("q${question}_a$i");
      }
      json["answer_image_keys"] = answerImageKeys;
    }

    return json;
  }
}
