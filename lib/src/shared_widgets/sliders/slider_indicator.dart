import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/core/utils/app_theme_util.dart';
import 'package:flutter/material.dart';

class SliderIndicator extends StatelessWidget {
  const SliderIndicator({super.key, this.isActive = false,});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: AppThemeUtil.radius(8),
      width: AppThemeUtil.radius(8),
      margin: EdgeInsets.symmetric(
        horizontal: AppThemeUtil.width(4.0),
      ),
      decoration: BoxDecoration(
        color: isActive? kPrimaryBlack : kGrey300,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
