import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programming_hero_task/controllers/high_score_controller.dart';
import 'package:programming_hero_task/theme/app_colors.dart';
import 'package:programming_hero_task/theme/app_text_styles.dart';
import 'package:programming_hero_task/theme/images.dart';
import 'package:programming_hero_task/ui/game_screen.dart';
import 'package:programming_hero_task/ui/widgets/primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HighScoreController highScoreController = Get.find();
    return Obx(() => Scaffold(
          backgroundColor: AppColors.primaryPurple,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DottedBorder(
                  borderType: BorderType.RRect,
                  color: AppColors.white,
                  strokeWidth: 2.5,
                  radius: const Radius.circular(12),
                  dashPattern: const <double>[10],
                  child: Container(
                    height: 250,
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage(Images.logo),
                        ),
                        Text(
                          'Quiz',
                          style: AppTextStyles.headerTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                DottedBorder(
                  borderType: BorderType.RRect,
                  color: AppColors.white,
                  strokeWidth: 2.5,
                  radius: const Radius.circular(12),
                  dashPattern: const <double>[10],
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Highscore',
                          style: AppTextStyles.commonTextStyleWhite,
                        ),
                        Text(
                          '${highScoreController.highScore.value} Point',
                          style: AppTextStyles.commonTextStyleWhite,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                DottedBorder(
                  borderType: BorderType.RRect,
                  color: AppColors.white,
                  strokeWidth: 2.5,
                  radius: const Radius.circular(12),
                  dashPattern: const <double>[10],
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: PrimaryButton(
                    label: 'Start',
                    onTap: () {
                      Get.to(const GameScreen());
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
