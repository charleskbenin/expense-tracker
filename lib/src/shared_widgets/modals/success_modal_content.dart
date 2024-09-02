import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/core/extensions/widgets/text_extension.dart';
import 'package:expense_tracker/core/utils/app_theme_util.dart';
import 'package:expense_tracker/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';

import '../base/popup_modal_body.dart';
import '../buttons/app_primary_button.dart';

class SuccessModalContent extends StatelessWidget {
  const SuccessModalContent({
    super.key,
    this.title = '',
    required this.message,
    this.onButtonPressed,
    this.verticalPadding,
    this.buttonText,
  });

  final String title;
  final String message;
  final VoidCallback? onButtonPressed;
  final double? verticalPadding;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return PopupModalBody(
      verticalPadding: verticalPadding ?? 16.0,
      title: Column(
        children: [
          const VSpace(height: 32.0),
          Icon(
            Icons.check_circle_outline_rounded,
            size: AppThemeUtil.radius(120.0),
            color: kSuccess600,
          ),
          if (title.isNotEmpty) ...[
            const VSpace(height: 16.0),
            Text(
              title,
            )
                .extraBold()
                .fontSize(20.0)
                .color(kPrimaryBlack)
                .alignText(TextAlign.center),
          ]
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppPrimaryButton(
              onPressed: onButtonPressed ??
                  () {
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  },
              text: buttonText ?? 'Okay',
            ),
          ],
        )
      ],
      child: message.isEmpty
          ? const SizedBox.shrink()
          : Text(message)
              .regular()
              .fontSize(16.0)
              .color(kPrimaryBlack)
              .alignText(TextAlign.center),
    );
  }
}
