

import 'package:expense_tracker/core/extensions/widgets/padding_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/text_style.dart';
import '../../../../../core/utils/app_theme_util.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({
    super.key,
    this.currentIndex = 0,
    this.onTap,
  });

  final int currentIndex;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFF8F8F8))),
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: AppThemeUtil.getThemeColor(kPrimaryWhite),
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: onTap,
            iconSize: AppThemeUtil.radius(24.0),
            selectedLabelStyle: kSemiBoldFontStyle.copyWith(
              fontSize: AppThemeUtil.fontSize(12.0),
              color: AppThemeUtil.getThemeColor(kBlue800),
              height: AppThemeUtil.getLineHeight(18.0, 12),
              letterSpacing: AppThemeUtil.getLetterSpacing(-0.13),
            ),
            unselectedLabelStyle: kMediumFontStyle.copyWith(
              fontSize: AppThemeUtil.fontSize(12.0),
              color: AppThemeUtil.getThemeColor(kGrey500),
              height: AppThemeUtil.getLineHeight(18.0, 12),
              letterSpacing: AppThemeUtil.getLetterSpacing(-0.13),
            ),
            selectedItemColor: AppThemeUtil.getThemeColor(kBlue800),
            unselectedItemColor: AppThemeUtil.getThemeColor(kGrey500),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard,
                  size: AppThemeUtil.radius(24.0),
                  color: currentIndex == 0 ? kBlue800 : kGrey500,
                ).paddingSymmetric(vertical: 4.0),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.monetization_on,
                  size: AppThemeUtil.radius(24.0),
                  color: currentIndex == 1 ? kBlue800 : kGrey500,
                ).paddingSymmetric(vertical: 4.0),
                label: 'Expenses',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: AppThemeUtil.radius(24.0),
                  color: currentIndex == 2 ? kBlue800 : kGrey500,
                ).paddingSymmetric(vertical: 4.0),
                label: 'Settings',
              ),
            ],
          ),
        )
    );
  }
}
