import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programming_hero_task/theme/app_colors.dart';
import 'package:programming_hero_task/theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color? borderColor;
  final VoidCallback? onTap;
  const PrimaryButton(
      {Key? key,
      this.isSelected = false,
      required this.label,
      this.onTap,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: borderColor ?? Colors.transparent, width: 3)
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.commonTextStyleWhite
                .copyWith(color: AppColors.primaryPurple),
          ),
        ),
      ),
    );
  }
}
