import 'package:expense_tracker/core/utils/app_theme_util.dart';
import 'package:expense_tracker/core/constants/colors.dart';
import 'package:flutter/material.dart';

class FieldEye extends StatelessWidget {
  const FieldEye({
    super.key,
    required this.onPressed,
    this.isHidden = true,
  });

  final void Function()? onPressed;
  final bool isHidden;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      highlightColor: Colors.transparent,
      icon: Icon(
          isHidden? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        size: AppThemeUtil.radius(20.0),
        color: AppThemeUtil.getThemeColor(kPrimaryBlack),
      )
    );
  }
}
