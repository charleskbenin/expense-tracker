
import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/core/extensions/widgets/padding_extension.dart';
import 'package:expense_tracker/core/extensions/widgets/text_extension.dart';
import 'package:expense_tracker/src/shared_widgets/buttons/app_primary_button.dart';
import 'package:expense_tracker/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:expense_tracker/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/utils/helper_util.dart';
import '../../features/dashboard/presentation/view_model/dashboard_view_model.dart';
import '../base/draggable_bottom_sheet.dart';
import '../forms/app_input_field.dart';
import '../forms/form_label.dart';
import 'draggable_bottom_sheet_content.dart';

class AddIncomeModal extends StatefulWidget {
  const AddIncomeModal({
    super.key,
  });

  @override
  State<AddIncomeModal> createState() => _AddIncomeModalState();
}

class _AddIncomeModalState extends State<AddIncomeModal> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final nameOfRevenue = TextEditingController();
  final amount = TextEditingController();

  @override
  void dispose() {
    nameOfRevenue.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      initialChildSize: HelperUtil.isIOS? 0.62 : 0.52,
      minChildSize: 0.50,
      maxChildSize: HelperUtil.isIOS? 0.62 : 0.52,
      builder: (context, scrollController){
        return DraggableBottomSheetContent(
          draggableKey: GlobalKey(),
          scrollController: scrollController,
          modalHeaderContent:  Row(
            children: [
              const Text("Add Income").bold().fontSize(30).color(kPrimaryBlack)
            ],
          ).paddingOnly(left: kWidthPadding, right: kWidthPadding, bottom: 10),
          bottomNavigationBar: AppBottomNavWrapper(
            child: AppPrimaryButton(
              onPressed: () async{
                if (formKey.currentState!.validate()) {
                  context.read<DashboardViewModel>().addIncome(
                      context,
                      requestBody: {
                        "nameOfRevenue": nameOfRevenue.text,
                        "amount": amount.text
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
                  const FormLabel(text: 'Name Of Revenue'),
                  const VSpace(height: 8.0),
                  AppInputField(
                    hintText: 'Name Of Revenue: Salary',
                    keyboardType: TextInputType.text,
                    controller: nameOfRevenue,
                    validator: (value) {
                      if (value!.isEmpty) return 'Name Of Revenue';

                      return null;
                    },
                  ),
                  const FormLabel(text: 'Amount'),
                  const VSpace(height: 8.0),
                  AppInputField(
                    hintText: 'Amount',
                    keyboardType: TextInputType.number,
                    controller: amount,
                    validator: (value) {
                      if (value!.isEmpty) return 'Amount is required';
              
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
