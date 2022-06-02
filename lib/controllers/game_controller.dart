import 'dart:async';

import 'package:get/get.dart';
import 'package:programming_hero_task/controllers/high_score_controller.dart';
import 'package:programming_hero_task/models/quiz_model.dart';
import 'package:programming_hero_task/repositories/quiz_repository.dart';

class GameController extends GetxController {
  RxList<QuizModel> quizList = <QuizModel>[].obs;
  RxInt currentQuestion = 0.obs;
  RxInt currentScore = 0.obs;
  RxString selectedOption = ''.obs;
  List<List<String>> answers = <List<String>>[];

  QuizRepository quizRepository = Get.find();
  HighScoreController highScoreController = Get.find();

  RxBool isFetchingData = true.obs;
  RxBool isOptionSelected = false.obs;
  RxBool gameEnd = false.obs;

  late Timer timer;
  RxInt remainingTime = 10000.obs;
  RxInt allottedTime = 10000.obs;

  void startTime() {
    timer = Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      remainingTime.value--;
    });
  }

  @override
  void onInit() {
    highScoreController.getHighScore();
    getQuestions();
    startTime();
    remainingTime.listen((int value) {
      if (value == 0) {
        timer.cancel();
        selectOption('');
      }
    });
    currentQuestion.listen((int value) {
      if (value != 0) {
        shuffleAnswers();
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void clear() {
    remainingTime.value = 10000;
    currentQuestion.value = 0;
    currentScore.value = 0;
    gameEnd.value = false;
    isOptionSelected.value = false;
  }

  void selectOption(String value) {
    if (value == '') {
      isOptionSelected.value = true;
      timer.cancel();
      Future.delayed(const Duration(seconds: 2), () {
        if (currentQuestion.value + 1 == quizList.length) {
          timer.cancel();
          endGame();
          return;
        }
        remainingTime.value = 10000;
        startTime();
        isOptionSelected.value = false;
        currentQuestion.value++;
      });
    } else {
      if (!isOptionSelected.value) {
        timer.cancel();
        isOptionSelected.value = true;
        selectedOption.value = value;
        if (selectedOption.value ==
            quizList[currentQuestion.value].correctAnswer) {
          currentScore.value += quizList[currentQuestion.value].score;
        }
        Future.delayed(const Duration(seconds: 2), () {
          if (currentQuestion.value + 1 == quizList.length) {
            timer.cancel();
            endGame();
            return;
          }
          selectedOption.value = '';
          isOptionSelected.value = false;
          currentQuestion.value++;
          remainingTime.value = 10000;
          startTime();
        });
      }
    }
  }

  void endGame() {
    if (currentScore.value > highScoreController.highScore.value) {
      highScoreController.setHighScore(currentScore.value);
      highScoreController.getHighScore();
    }
    gameEnd.value = true;
  }

  void getQuestions() async {
    quizList.addAll(await quizRepository.getQuestions());
    isFetchingData.value = false;
    shuffleAnswers();
  }

  void shuffleAnswers() {
    answers.clear();
    if (quizList[currentQuestion.value].answers.a != null) {
      answers.add(['A', quizList[currentQuestion.value].answers.a!]);
    }
    if (quizList[currentQuestion.value].answers.b != null) {
      answers.add(['B', quizList[currentQuestion.value].answers.b!]);
    }
    if (quizList[currentQuestion.value].answers.c != null) {
      answers.add(['C', quizList[currentQuestion.value].answers.c!]);
    }
    if (quizList[currentQuestion.value].answers.d != null) {
      answers.add(['D', quizList[currentQuestion.value].answers.d!]);
    }
    answers.shuffle();
  }
}
