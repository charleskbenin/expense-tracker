
import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/core/constants/common.dart';
import 'package:expense_tracker/core/extensions/widgets/padding_extension.dart';
import 'package:expense_tracker/core/extensions/widgets/text_extension.dart';
import 'package:expense_tracker/src/shared_widgets/base/app_screen_scaffold.dart';
import 'package:expense_tracker/src/shared_widgets/common/app_bottom_nav_wrapper.dart';
import 'package:expense_tracker/src/shared_widgets/common/v_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/view_models/user_view_model.dart';
import '../../../../../shared_widgets/buttons/app_primary_button.dart';
import '../../../../../shared_widgets/forms/app_input_field.dart';
import '../../../../../shared_widgets/forms/field_eye.dart';
import '../../../../../shared_widgets/forms/form_label.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final isHidden = ValueNotifier<bool>(true);

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenScaffold(
      bottomNavigationBar: AppBottomNavWrapper(
        child: AppPrimaryButton(
          onPressed: () async{
            if (formKey.currentState!.validate()) {
              await context.read<UserViewModel>().authentication(
                context,
                type: 'signup',
                requestBody: {
                  "name": nameController.text,
                  "email": emailController.text,
                  "password": passwordController.text,
                },
              );
            } else {
              setState(() => autoValidate = AutovalidateMode.onUserInteraction);
            }
          },
          minWidth: double.infinity,
          text: 'Sign Up',
        ),
      ),
      child: Form(
        key: formKey,
        autovalidateMode: autoValidate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create an account").extraBold().fontSize(24).color(kPrimaryBlack),
            const VSpace(height: 18.0),
            const FormLabel(text: 'Name'),
            const VSpace(height: 8.0),
            AppInputField(
              hintText: 'Enter your name',
              keyboardType: TextInputType.emailAddress,
              controller: nameController,
              validator: (value) {
                if (value!.isEmpty) return 'Name is required';

                return null;
              },
            ),
            const FormLabel(text: 'Email'),
            const VSpace(height: 8.0),
            AppInputField(
              hintText: 'Enter email',
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              validator: (value) {
                if (value!.isEmpty) return 'Email is required';

                return null;
              },
            ),

            const FormLabel(text: 'Password'),
            const VSpace(height: 8.0),

            ValueListenableBuilder<bool>(
                valueListenable: isHidden,
                builder: (context, isHiddenValue, child) {
                  return AppInputField(
                    hintText: 'Enter password',
                    obscureText: isHiddenValue,
                    suffixIcon: FieldEye(
                      onPressed: (){
                        isHidden.value = !isHiddenValue;
                      },
                      isHidden: isHiddenValue,
                    ),
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) return 'Password is required';
                      if (value.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                  );
                }
            ),
          ],
        ),
      ).paddingSymmetric(horizontal: kWidthPadding)
    );
  }
}
