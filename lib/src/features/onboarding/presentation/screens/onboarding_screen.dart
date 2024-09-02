import 'package:expense_tracker/core/extensions/widgets/align_extension.dart';
import 'package:expense_tracker/core/extensions/widgets/padding_extension.dart';
import 'package:expense_tracker/core/extensions/widgets/text_extension.dart';
import 'package:expense_tracker/core/routing/app_navigator.dart';
import 'package:expense_tracker/core/routing/app_route.dart';
import 'package:expense_tracker/core/utils/app_theme_util.dart';
import 'package:expense_tracker/core/constants/common.dart';
import 'package:expense_tracker/core/constants/text_style.dart';
import 'package:expense_tracker/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:expense_tracker/src/shared_widgets/sliders/slider_indicator.dart';
import 'package:expense_tracker/src/shared_widgets/sliders/zcarousel.dart';
import 'package:expense_tracker/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../auth/sign_in/presentation/screens/sign_in_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final selectedIndex = ValueNotifier<int>(0);

  final sliders = [
    <String, dynamic>{
      'text': 'Manage Your Finances with Ease',
      'image': '$kImagePath/onboard1.jpeg',
      'color': kBlue100,
    },
    <String, dynamic>{
      'text': 'Your Personal Finance Assistant',
      'image': '$kImagePath/onboard1.jpeg',
      'color': kBlue100,
    },
    <String, dynamic>{
      'text': 'Achieve Your Financial Goals',
      'image': '$kImagePath/onboard1.jpeg',
      'color': kBlue100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, selectedIndexValue, child) {
        final item = sliders[selectedIndexValue];
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: item['color'],
          body: SafeArea(
            child: child!,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const VSpace(height: 32.0),
          const Text('WELCOME TO L•E•T').bold().color(kPrimaryBlack).fontSize(24.0).letterSpacing(-1.1).height(36.0, 24.0).alignCenter().paddingSymmetric(horizontal: kWidthPadding),
          const Spacer(flex: 1),
          // const VSpace(height: 42.0),
          ZCarousel(
            height: MediaQuery.of(context).size.height * 0.5,
            viewportFraction: 1.0,
            autoPlay: true,
            itemCount: sliders.length,
            itemBuilder: (context, index, i){
              final slider = sliders[index];
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: AppThemeUtil.width(338),
                    child: Image.asset(slider['image']),
                  ).paddingSymmetric(horizontal: 38.0),
                  VSpace(height: MediaQuery.of(context).size.height * 0.03),
                  Text(slider['text']?? '').semiBold().color(kPrimaryBlack).fontSize(20).letterSpacing(-1.1).alignText(TextAlign.center).alignCenter().paddingSymmetric(horizontal: kWidthPadding)
                ],
              );
            },
            onPageChanged: (index, reason){
              selectedIndex.value = index;
            },
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(sliders.length, (index) => ValueListenableBuilder<int>(
                valueListenable: selectedIndex,
                builder: (context, selectedIndexValue, child) {
                  return SliderIndicator(isActive: index == selectedIndexValue,);
                }
            )),
          ),

          const Spacer(flex: 1),
          AppPrimaryButton(
            onPressed: (){
              AppDialogUtil.showScrollableBottomSheet(
                context: context,
                builder: (context) => const LoginScreen(),
              );
            },
            minWidth: double.infinity,
            text: 'Log in',
          ).paddingSymmetric(horizontal: kWidthPadding),

          const VSpace(height: 16.0),
          AppPrimaryButton(
            onPressed: (){
              AppNavigator.pushNamed(context, AppRoute.signUpScreen);
            },
            minWidth: double.infinity,
            text: 'Sign up',
            borderColor: kGrey1200,
            textColor: kGrey1200,
            color: Colors.transparent,
          ).paddingSymmetric(horizontal: kWidthPadding),
          const Spacer(flex: 2),
          RichText(
            text: TextSpan(
                text: 'I agree that I have read and accepted the ',
                style: kRegularFontStyle.copyWith(
                  fontSize: AppThemeUtil.fontSize(14.0),
                  color: kGrey500,
                ),
                children: [
                  TextSpan(
                    text: 'Terms of Use ',
                    style: kSemiBoldFontStyle.copyWith(
                      fontSize: AppThemeUtil.fontSize(14.0),
                      color: kPrimaryBlack,
                    ),
                  ),
                  TextSpan(
                    text: 'and ',
                    style: kRegularFontStyle.copyWith(
                      fontSize: AppThemeUtil.fontSize(14.0),
                      color: kGrey500,
                    ),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: kSemiBoldFontStyle.copyWith(
                      fontSize: AppThemeUtil.fontSize(14.0),
                      color: kPrimaryBlack,
                    ),
                  ),
                ]
            ),
            textAlign: TextAlign.center,
          ).alignCenter().paddingSymmetric(horizontal: kWidthPadding),
          const VSpace(height: 16.0),
        ],
      ),
    );
  }

}