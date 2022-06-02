import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:programming_hero_task/controllers/game_controller.dart';
import 'package:programming_hero_task/theme/app_colors.dart';
import 'package:programming_hero_task/theme/app_text_styles.dart';
import 'package:programming_hero_task/ui/home_screen.dart';
import 'package:programming_hero_task/ui/widgets/primary_button.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameController controller = Get.put(GameController());

  @override
  void initState() {
    controller.clear();
    controller.gameEnd.listen((bool value) {
      if (value) {
        AwesomeDialog(
          context: context,
          dialogBackgroundColor: AppColors.primaryPurple,
          buttonsTextStyle: AppTextStyles.timerTextStylePurple,
          btnOkColor: AppColors.white,
          titleTextStyle: AppTextStyles.commonTextStyleWhite,
          descTextStyle: AppTextStyles.timerTextStylePurple
              .copyWith(color: AppColors.white),
          dialogType: DialogType.INFO,
          animType: AnimType.BOTTOMSLIDE,
          title: controller.currentScore.value >
                  controller.highScoreController.highScore.value
              ? 'New High Score!!'
              : 'Quiz completed',
          desc: controller.currentScore.value >
                  controller.highScoreController.highScore.value
              ? 'Congratulations! You have scored a new high score of: ${controller.currentScore.value}'
              : 'Your Score: ${controller.currentScore.value}',
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          btnOkOnPress: () {
            Get.off(() => const HomeScreen());
          },
        ).show();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: AppColors.primaryPurple,
          body: controller.isFetchingData.value
              ? SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      LoadingAnimationWidget.beat(
                        color: AppColors.white,
                        size: 100,
                      ).paddingOnly(bottom: 20),
                      Text(
                        'Generating questions!',
                        style: AppTextStyles.commonTextStyleWhite,
                      ),
                    ],
                  ),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: Get.width,
                          color: AppColors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            color: AppColors.primaryPurple,
                            strokeWidth: 2.5,
                            radius: const Radius.circular(8),
                            dashPattern: const <double>[10],
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Questions: ${controller.currentQuestion.value + 1}/${controller.quizList.length}',
                                    style: AppTextStyles.commonTextStylePurple,
                                  ).paddingOnly(left: 20),
                                  Text(
                                    'Score: ${controller.currentScore.value}',
                                    style: AppTextStyles.commonTextStylePurple,
                                  ).paddingOnly(
                                    right: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ).paddingOnly(bottom: 20, top: 5),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            color: AppColors.primaryPurple,
                            strokeWidth: 2.5,
                            radius: const Radius.circular(8),
                            dashPattern: const <double>[10],
                            child: Container(
                              width: Get.width,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    '${controller.quizList[controller.currentQuestion.value].score} Points',
                                    style: AppTextStyles.commonTextStylePurple,
                                  ).paddingSymmetric(vertical: 10),
                                  if (controller
                                              .quizList[controller
                                                  .currentQuestion.value]
                                              .questionImageUrl !=
                                          null &&
                                      controller
                                              .quizList[controller
                                                  .currentQuestion.value]
                                              .questionImageUrl !=
                                          'null')
                                    Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            controller
                                                .quizList[controller
                                                    .currentQuestion.value]
                                                .questionImageUrl!,
                                          ),
                                        ),
                                      ),
                                    ).paddingOnly(bottom: 10),
                                  Text(
                                    controller
                                        .quizList[
                                            controller.currentQuestion.value]
                                        .question,
                                    style: AppTextStyles.commonTextStylePurple,
                                    textAlign: TextAlign.center,
                                  ).paddingOnly(bottom: 10),
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        CircularProgressIndicator(
                                          color: AppColors.primaryPurple,
                                          value: 1 -
                                              controller.remainingTime.value /
                                                  controller.allottedTime.value,
                                        ),
                                        Center(
                                          child: Text(
                                            (controller.remainingTime.value
                                                        .toDouble() /
                                                    1000)
                                                .toStringAsFixed(2),
                                            style: AppTextStyles
                                                .timerTextStylePurple,
                                          ),
                                        )
                                      ],
                                    ),
                                  ).paddingOnly(bottom: 10)
                                ],
                              ),
                            ),
                          ),
                        ).paddingOnly(bottom: 40, right: 20, left: 20),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          color: AppColors.white,
                          strokeWidth: 2.5,
                          radius: const Radius.circular(12),
                          dashPattern: const <double>[10],
                          child: Column(
                            children: <Widget>[
                              controller.answers.isNotEmpty
                                  ? PrimaryButton(
                                      label: controller.answers[0][1],
                                      isSelected: controller
                                                  .selectedOption.value ==
                                              controller.answers[0][0] ||
                                          (controller
                                                      .quizList[controller
                                                          .currentQuestion
                                                          .value]
                                                      .correctAnswer ==
                                                  controller.answers[0][0] &&
                                              controller
                                                  .isOptionSelected.value),
                                      borderColor: controller
                                                  .quizList[controller
                                                      .currentQuestion.value]
                                                  .correctAnswer ==
                                              controller.answers[0][0]
                                          ? AppColors.primaryGreen
                                          : AppColors.primaryRed,
                                      onTap: () => controller.selectOption(
                                          controller.answers[0][0]),
                                    ).paddingOnly(
                                      bottom: 20, right: 20, left: 20, top: 20)
                                  : const SizedBox(),
                              controller.answers.length > 1
                                  ? PrimaryButton(
                                      label: controller.answers[1][1],
                                      isSelected: controller
                                                  .selectedOption.value ==
                                              controller.answers[1][0] ||
                                          (controller
                                                      .quizList[controller
                                                          .currentQuestion
                                                          .value]
                                                      .correctAnswer ==
                                                  controller.answers[1][0] &&
                                              controller
                                                  .isOptionSelected.value),
                                      onTap: () => controller.selectOption(
                                          controller.answers[1][0]),
                                      borderColor: controller
                                                  .quizList[controller
                                                      .currentQuestion.value]
                                                  .correctAnswer ==
                                              controller.answers[1][0]
                                          ? AppColors.primaryGreen
                                          : AppColors.primaryRed,
                                    ).paddingOnly(
                                      bottom: 20, right: 20, left: 20)
                                  : const SizedBox(),
                              controller.answers.length > 2
                                  ? PrimaryButton(
                                      label: controller.answers[2][1],
                                      isSelected: controller
                                                  .selectedOption.value ==
                                              controller.answers[2][0] ||
                                          (controller
                                                      .quizList[controller
                                                          .currentQuestion
                                                          .value]
                                                      .correctAnswer ==
                                                  controller.answers[2][0] &&
                                              controller
                                                  .isOptionSelected.value),
                                      onTap: () => controller.selectOption(
                                          controller.answers[2][0]),
                                      borderColor: controller
                                                  .quizList[controller
                                                      .currentQuestion.value]
                                                  .correctAnswer ==
                                              controller.answers[2][0]
                                          ? AppColors.primaryGreen
                                          : AppColors.primaryRed,
                                    ).paddingOnly(
                                      bottom: 20, right: 20, left: 20)
                                  : const SizedBox(),
                              controller.answers.length > 3
                                  ? PrimaryButton(
                                      label: controller.answers[3][1],
                                      isSelected: controller
                                                  .selectedOption.value ==
                                              controller.answers[3][0] ||
                                          (controller
                                                      .quizList[controller
                                                          .currentQuestion
                                                          .value]
                                                      .correctAnswer ==
                                                  controller.answers[3][0] &&
                                              controller
                                                  .isOptionSelected.value),
                                      onTap: () => controller.selectOption(
                                          controller.answers[3][0]),
                                      borderColor: controller
                                                  .quizList[controller
                                                      .currentQuestion.value]
                                                  .correctAnswer ==
                                              controller.answers[3][0]
                                          ? AppColors.primaryGreen
                                          : AppColors.primaryRed,
                                    ).paddingOnly(
                                      bottom: 20, right: 20, left: 20)
                                  : const SizedBox(),
                            ],
                          ),
                        ).paddingSymmetric(horizontal: 20),
                      ],
                    ).paddingOnly(bottom: 20),
                  ),
                ),
        ));
  }
}
