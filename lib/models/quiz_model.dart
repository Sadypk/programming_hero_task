// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

import 'dart:convert';

import 'package:programming_hero_task/models/answers_model.dart';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  QuizModel({
    required this.question,
    required this.answers,
    this.questionImageUrl,
    required this.correctAnswer,
    required this.score,
  });

  String question;
  AnswerModel answers;
  String? questionImageUrl;
  String correctAnswer;
  int score;

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        question: json["question"],
        answers: AnswerModel.fromJson(json["answers"]),
        questionImageUrl: json["questionImageUrl"] != 'null?'
            ? json["questionImageUrl"]
            : null,
        correctAnswer: json["correctAnswer"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answers": answers.toJson(),
        "questionImageUrl": questionImageUrl,
        "correctAnswer": correctAnswer,
        "score": score,
      };
}
