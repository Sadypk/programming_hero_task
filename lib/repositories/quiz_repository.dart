import 'package:dio/dio.dart';
import 'package:programming_hero_task/models/question_model.dart';
import 'package:programming_hero_task/models/quiz_model.dart';

class QuizRepository {
  Future<List<QuizModel>> getQuestions() async {
    try {
      var response = await Dio()
          .get('https://herosapp.nyc3.digitaloceanspaces.com/quiz.json');
      Question question = Question.fromJson(response.data);
      return question.questions;
    } catch (e) {
      print(e);
      return <QuizModel>[];
    }
  }
}
