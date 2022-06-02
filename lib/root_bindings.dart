import 'package:get/get.dart';
import 'package:programming_hero_task/controllers/high_score_controller.dart';
import 'package:programming_hero_task/repositories/quiz_repository.dart';

class RootBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HighScoreController>(() => HighScoreController(), fenix: true);
    Get.lazyPut<QuizRepository>(() => QuizRepository(), fenix: true);
  }
}
