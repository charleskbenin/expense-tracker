
import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/core/utils/app_theme_util.dart';
import 'package:flutter/cupertino.dart';

class AppSwitchButton extends StatelessWidget {
  final bool value;
  final void Function(bool)? onChanged;

  const AppSwitchButton({
    super.key,
    this.value = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.6,
      child: CupertinoSwitch(
          value: value,
          activeColor: AppThemeUtil.getThemeColor(kPrimaryBlack),
          trackColor: AppThemeUtil.getThemeColor(kGrey200),
          onChanged: onChanged
      ),
    );
  }
}
