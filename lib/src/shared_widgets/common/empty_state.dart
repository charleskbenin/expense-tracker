
import 'package:expense_tracker/core/extensions/widgets/text_extension.dart';
import 'package:expense_tracker/core/utils/app_theme_util.dart';
import 'package:expense_tracker/src/shared_widgets/common/h_space.dart';
import 'package:expense_tracker/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/common.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.title = 'Transactions',
    this.subtitle = 'No transaction to display',
    this.isVertical = true,
    this.customButton,
    this.titleTextStyle,
    this.iconData,
    this.iconColor,
    this.iconWidget,
  });

  final String title;
  final String subtitle;
  final bool isVertical;
  final Widget? customButton;
  final TextStyle? titleTextStyle;
  final IconData? iconData;
  final Color? iconColor;
  final Widget? iconWidget;


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: AppThemeUtil.width(kWidthPadding),
      ),
      child: isVertical ?
      Column(
        children: [
          iconWidget?? Icon(
            iconData?? Icons.folder_open,
            size: AppThemeUtil.radius(24.0),
            color: AppThemeUtil.getThemeColor(iconColor?? kPrimaryBlack),
          ),
          const VSpace(height: 10),
          if(title.isNotEmpty)Text(
            title,
          ).semiBold().fontSize(14.0).color(kPrimaryBlack).alignText(TextAlign.center),
          const VSpace(height: 5),
          Text(
            subtitle,
          ).medium().fontSize(16.0).color(kGrey1200).alignText(TextAlign.center),
          if(customButton != null) const VSpace(height: 16),
          if(customButton != null) customButton!,
        ],
      )
          :
      Row(
        children: [
          iconWidget?? Icon(
            iconData?? Icons.folder_open,
            size: AppThemeUtil.radius(24.0),
            color: AppThemeUtil.getThemeColor(iconColor?? kPrimaryBlack),
          ),
          const HSpace(width: 10),
          Column(
            children: [
              if(title.isNotEmpty) ...[
                Text(
                  title,
                ).semiBold().fontSize(14.0).color(kPrimaryBlack).alignText(TextAlign.center),
                const VSpace(height: 5),
              ],
              Text(
                subtitle,
              ).medium().fontSize(16.0).color(kGrey1200).height(24.0, 12.0).alignText(TextAlign.center),
            ],
          ),
        ],
      ),
    );
  }
}
