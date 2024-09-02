import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/core/extensions/widgets/expanded_extension.dart';
import 'package:expense_tracker/core/extensions/widgets/padding_extension.dart';
import 'package:expense_tracker/core/extensions/widgets/text_extension.dart';
import 'package:expense_tracker/core/routing/app_navigator.dart';
import 'package:expense_tracker/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:expense_tracker/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:expense_tracker/src/shared_widgets/common/h_space.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/common.dart';
import '../../../core/utils/app_dialog_util.dart';
import '../../../core/utils/helper_util.dart';
import '../base/draggable_bottom_sheet.dart';
import 'add_expenditure_modal.dart';
import 'add_income_modal.dart';
import 'draggable_bottom_sheet_content.dart';

class AddIncomeOrExpenditureModal extends StatefulWidget {
  const AddIncomeOrExpenditureModal({
    super.key,
  });

  @override
  State<AddIncomeOrExpenditureModal> createState() =>
      _AddIncomeOrExpenditureModalState();
}

class _AddIncomeOrExpenditureModalState
    extends State<AddIncomeOrExpenditureModal> {
  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: HelperUtil.isIOS ? 0.40 : 0.35,
      minChildSize: 0.360,
      maxChildSize: HelperUtil.isIOS ? 0.41 : 0.36,
      builder: (context, scrollController) {
        return DraggableBottomSheetContent(
            draggableKey: GlobalKey(),
            scrollController: scrollController,
            hasBottomBorder: false,
            modalHeaderContent: Row(
              children: [
                const Text("Add Expense or Income")
                    .bold()
                    .fontSize(30)
                    .color(kPrimaryBlack)
              ],
            ).paddingOnly(
                left: kWidthPadding, right: kWidthPadding, bottom: 10),
            bottomNavigationBar: AppBottomNavWrapper(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppPrimaryButton(
                    onPressed: () async {
                      AppNavigator.pop(context);
                      AppDialogUtil.showScrollableBottomSheet(
                        context: context,
                        builder: (context) =>  const AddExpenditureModal(),
                      );
                    },
                    text: 'Expense',
                  ).expanded(),
                  const HSpace(width: 10),
                  AppPrimaryButton(
                    onPressed: () async {
                      AppNavigator.pop(context);
                      AppDialogUtil.showScrollableBottomSheet(
                        context: context,
                        builder: (context) =>  const AddIncomeModal(),
                      );
                    },
                    text: 'Income',
                  ).expanded(),
                ],
              ),
            ),
            content: const Text("Please select an option to proceed").bold().fontSize(16).color(kPrimaryBlack).paddingSymmetric(horizontal: kWidthPadding));
      },
    );
  }
}
