
import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/core/extensions/widgets/padding_extension.dart';
import 'package:expense_tracker/core/extensions/widgets/text_extension.dart';
import 'package:expense_tracker/src/features/expense/presentation/view_model/expense_view_model.dart';
import 'package:expense_tracker/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:expense_tracker/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:expense_tracker/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/utils/helper_util.dart';
import '../base/draggable_bottom_sheet.dart';
import '../forms/app_input_field.dart';
import '../forms/form_label.dart';
import 'draggable_bottom_sheet_content.dart';

class AddExpenditureModal extends StatefulWidget {
  const AddExpenditureModal({
    super.key,
  });

  @override
  State<AddExpenditureModal> createState() => _AddExpenditureModalState();
}

class _AddExpenditureModalState extends State<AddExpenditureModal> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final category = TextEditingController();
  final estimatedAmount = TextEditingController();
  final nameOfItem = TextEditingController();

  @override
  void dispose() {
    category.dispose();
    estimatedAmount.dispose();
    nameOfItem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: HelperUtil.isIOS? 0.82 : 0.72,
      minChildSize: 0.50,
      maxChildSize: HelperUtil.isIOS? 0.82 : 0.72,
      builder: (context, scrollController){
        return DraggableBottomSheetContent(
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          modalHeaderContent:  Row(
            children: [
              const Text("Add Expense").bold().fontSize(30).color(kPrimaryBlack)
            ],
          ).paddingOnly(left: kWidthPadding, right: kWidthPadding, bottom: 10),
          bottomNavigationBar: AppBottomNavWrapper(
            child: AppPrimaryButton(
              onPressed: () async{
                if (formKey.currentState!.validate()) {
                  context.read<ExpenseViewModel>().addExpenditure(
                      context,
                      requestBody: {
                        "category": category.text,
                        "nameOfItem": nameOfItem.text,
                        "estimatedAmount": estimatedAmount.text
                      },
                  );
                } else {
                  setState(() => autoValidate = AutovalidateMode.onUserInteraction);
                }
              },
              minWidth: double.infinity,
              text: 'Submit',
            ),
          ),
          content: Form(
            key: formKey,
            autovalidateMode: autoValidate,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VSpace(height: 18.0),
                  const FormLabel(text: 'Categories'),
                  const VSpace(height: 8.0),
                  AppInputField(
                    hintText: 'categories eg: Food',
                    keyboardType: TextInputType.text,
                    controller: category,
                    validator: (value) {
                      if (value!.isEmpty) return 'Category is required';
              
                      return null;
                    },
                  ),
                  const FormLabel(text: 'Estimated Amount'),
                  const VSpace(height: 8.0),
                  AppInputField(
                    hintText: 'Estimated Amount',
                    keyboardType: TextInputType.number,
                    controller: estimatedAmount,
                    validator: (value) {
                      if (value!.isEmpty) return 'Estimated Amount is required';
              
                      return null;
                    },
                  ),
                  const FormLabel(text: 'Name of Item'),
                  const VSpace(height: 8.0),
                  AppInputField(
                    hintText: 'Name of Item',
                    keyboardType: TextInputType.text,
                    controller: nameOfItem,
                    validator: (value) {
                      if (value!.isEmpty) return 'Name of Item is required';
              
                      return null;
                    },
                  ),
                  const VSpace(height: 16.0),
                ],
              ),
            ),
          ).paddingSymmetric(horizontal: kWidthPadding)
        );
      },
    );

  }
}
