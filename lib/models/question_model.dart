import 'package:programming_hero_task/models/quiz_model.dart';

class Question {
  Question({
    required this.questions,
  });

  List<QuizModel> questions;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questions: List<QuizModel>.from(
            json["questions"].map((x) => QuizModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}
