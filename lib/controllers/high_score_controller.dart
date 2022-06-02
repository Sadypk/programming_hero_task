import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighScoreController extends GetxController {
  RxInt highScore = 0.obs;

  @override
  void onInit() {
    getHighScore();
    super.onInit();
  }

  void getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    highScore.value = prefs.getInt('high_score') ?? 0;
  }

  void setHighScore(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('high_score', value);
  }
}
